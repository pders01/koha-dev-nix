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
            echo "Koha dev shell ready. PerlNavigator should resolve modules."
            echo "Note: Some modules are stubs (see stubs/ and TODO.md)"
          '';
        };
      }
    );
}
