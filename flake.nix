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

          # Code quality
          PerlTidy
          PerlCritic

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

            # Frontend development
            pkgs.nodejs_20
            pkgs.yarn
            pkgs.nodePackages.typescript
            pkgs.nodePackages.typescript-language-server
          ] ++ nativeLibs;

          shellHook = ''
            # Resolve KOHA_SRC - use SYNC_REPO if KOHA_SRC not set (ktd compatibility)
            if [ -z "$KOHA_SRC" ] && [ -n "$SYNC_REPO" ]; then
              export KOHA_SRC="$SYNC_REPO"
            fi

            if [ -z "$KOHA_SRC" ]; then
              echo -e "\033[0;31mError: KOHA_SRC is not set.\033[0m"
              echo "Add to your shell profile: export KOHA_SRC=/path/to/koha"
              echo "Or if you use ktd: export KOHA_SRC=\$SYNC_REPO"
              return 1
            fi

            if [ ! -d "$KOHA_SRC" ]; then
              echo -e "\033[0;31mError: KOHA_SRC ($KOHA_SRC) does not exist.\033[0m"
              return 1
            fi

            # Add Koha source and stubs to PERL5LIB
            export PERL5LIB="$PWD/stubs:$KOHA_SRC:$PERL5LIB"

            # Store the dev directory for commands
            export KOHA_DEV_NIX="$PWD"

            # Add scripts to PATH
            export PATH="$PWD/scripts:$PATH"

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
            echo -e "''${CYAN}│''${NC}  Module coverage: ''${GREEN}1264/1266 (99.8%)''${NC}         ''${CYAN}│''${NC}"
            echo -e "''${CYAN}╰─────────────────────────────────────────────╯''${NC}"
            echo ""
            echo -e "''${BOLD}Commands:''${NC}"
            echo -e "  ''${YELLOW}koha-test''${NC}        Run full module test"
            echo -e "  ''${YELLOW}koha-check''${NC}       Test specific module (e.g., koha-check C4::Biblio)"
            echo -e "  ''${YELLOW}koha-missing''${NC}     Find missing external dependencies"
            echo -e "  ''${YELLOW}koha-stubs''${NC}       List all stub modules"
            echo -e "  ''${YELLOW}koha-yarn''${NC}        Run yarn in Koha directory (e.g., koha-yarn build)"
            echo ""

          '';
        };
      }
    );
}
