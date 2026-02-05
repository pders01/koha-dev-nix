{
  description = "Koha development environment for PerlNavigator LSP";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Native libraries needed by XS modules
        nativeLibs = with pkgs; [
          libxml2
          libxslt
          gd
          openssl
          zlib
          icu
          libiconv
          expat
          mariadb-connector-c
        ];

        # Perl with packages from nixpkgs
        perlEnv = pkgs.perl.withPackages (ps: with ps; [
          # Core
          ModernPerl
          TryTiny
          Clone
          Readonly
          ClassAccessor
          ClassInspector
          ClassFactoryUtil
          ExceptionClass

          # Database
          DBI
          DBDmysql
          DBDSQLite
          DBIxClass
          DBIxClassSchemaLoader

          # Web/Plack/Mojo
          Mojolicious
          MojoJWT
          Plack
          PlackMiddlewareReverseProxy
          Starman

          # CGI
          CGI
          CGICompile
          CGIEmulatePSGI
          CGISession

          # HTTP/LWP
          LWP
          LWPProtocolhttps
          HTTPMessage
          HTTPCookies
          HTTPDate
          URI

          # JSON/YAML/XML
          JSON
          JSONXS
          YAMLLibYAML
          XMLLibXML
          XMLLibXSLT
          XMLSimple
          XMLWriter
          XMLRSS
          XMLSAXWriter

          # Template
          TemplateToolkit

          # DateTime
          DateTime
          DateTimeFormatMySQL
          DateTimeFormatICal
          DateTimeEventICal
          DateTimeTimeZone
          DateTimeLocale
          DateCalc
          DateManip

          # Email
          EmailSender
          EmailStuffer
          EmailAddress
          EmailMessageID
          EmailMIME
          EmailSimple
          EmailValid

          # Caching
          CacheMemcached
          CacheMemcachedFast
          CacheCache

          # Crypto
          CryptCBC
          CryptEksblowfish
          CryptOpenSSLRSA
          CryptOpenSSLBignum
          DigestSHA
          DigestMD5
          BytesRandomSecure

          # PDF
          PDFAPI2

          # Image
          GD

          # Text/HTML
          TextCSV
          TextCSV_XS
          TextCSVEncoded
          TextIconv
          HTMLParser
          HTMLScrubber
          HTMLFormatter

          # Logging
          LogLog4perl

          # Testing
          TestSimple
          TestException
          TestDeep
          TestWarn
          TestMockModule
          TestMockObject

          # Utilities
          ListMoreUtils
          FileSlurp
          ParallelForkManager
          StringRandom
          NumberFormat
          ArchiveZip
          FontTTF
          SQLTranslator
          DataUUID
          EncodeLocale
          AlgorithmCheckDigits
          AlgorithmDiff

          # Business
          BusinessISBN
          BusinessISSN

          # Locale
          LocalePO
          LocaleGettext
          LocaleCodes
          libintl-perl

          # Net
          NetLDAP
          NetCIDR
          NetNetmask
          NetSFTPForeign

          # Documents
          OpenOfficeOODoc
          ModuleCPANfile

          # Data
          DataICal
          DataDumper

          # Serialization
          Sereal
          Storable
        ]);

      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            perlEnv
            pkgs.perlnavigator
          ] ++ nativeLibs;

          shellHook = ''
            # Add Koha source and stubs to PERL5LIB
            export PERL5LIB="$PWD/stubs:$PWD/../koha:$PERL5LIB"

            # Store the dev directory for commands
            export KOHA_DEV_NIX="$PWD"
            export KOHA_SRC="$PWD/../koha"

            # Colors
            RED='\033[0;31m'
            GREEN='\033[0;32m'
            YELLOW='\033[1;33m'
            BLUE='\033[0;34m'
            CYAN='\033[0;36m'
            BOLD='\033[1m'
            NC='\033[0m' # No Color

            # Welcome banner
            echo ""
            echo -e "''${CYAN}╭─────────────────────────────────────────────╮''${NC}"
            echo -e "''${CYAN}│''${NC}  ''${BOLD}Koha Development Environment''${NC}               ''${CYAN}│''${NC}"
            echo -e "''${CYAN}│''${NC}  Module coverage: ''${GREEN}1243/1245 (99.8%)''${NC}         ''${CYAN}│''${NC}"
            echo -e "''${CYAN}╰─────────────────────────────────────────────╯''${NC}"
            echo ""
            echo -e "''${BOLD}Commands:''${NC}"
            echo -e "  ''${YELLOW}koha-test''${NC}        Run full module test"
            echo -e "  ''${YELLOW}koha-check''${NC}       Test specific module (e.g., koha-check C4::Biblio)"
            echo -e "  ''${YELLOW}koha-missing''${NC}     Find missing external dependencies"
            echo -e "  ''${YELLOW}koha-stubs''${NC}       List all stub modules"
            echo ""

            # Shell functions
            koha-test() {
              echo -e "''${BLUE}Running full module test...''${NC}"
              cd "$KOHA_DEV_NIX" && perl test_all_modules.pl
            }

            koha-check() {
              if [ -z "$1" ]; then
                echo -e "''${RED}Usage: koha-check <Module::Name>''${NC}"
                echo "Example: koha-check C4::Biblio"
                return 1
              fi
              echo -e "''${BLUE}Testing $1...''${NC}"
              local output
              output=$(perl -I"$KOHA_DEV_NIX/stubs" -I"$KOHA_SRC" -e "use $1; print \"OK\n\"" 2>&1)
              local exit_code=$?
              if [ $exit_code -eq 0 ]; then
                echo -e "''${GREEN}OK''${NC}: $1 loaded successfully"
              else
                echo -e "''${RED}FAILED''${NC}: $1 could not be loaded"
                echo "$output" | grep -v "unable to locate Koha configuration" | grep -v "^Use of uninitialized value" | head -10
              fi
              return $exit_code
            }

            koha-missing() {
              echo -e "''${BLUE}Finding missing dependencies...''${NC}"
              cd "$KOHA_DEV_NIX" && perl find_missing.pl
            }

            koha-stubs() {
              echo -e "''${BOLD}Stub modules in $KOHA_DEV_NIX/stubs/:''${NC}"
              find "$KOHA_DEV_NIX/stubs" -name "*.pm" | sed "s|$KOHA_DEV_NIX/stubs/||" | sed 's|/|::|g' | sed 's|\.pm$||' | sort
            }

            export -f koha-test koha-check koha-missing koha-stubs

            # Custom prompt
            export PS1="\[\033[0;36m\][koha-dev]\[\033[0m\] \w $ "
          '';
        };
      }
    );
}
