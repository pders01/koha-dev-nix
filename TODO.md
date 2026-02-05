# TODO

## Current Status

✅ **Working** - Core Koha modules load successfully for PerlNavigator LSP support.

Tested modules:
- C4::Context, C4::Biblio, C4::Auth, C4::Circulation
- C4::Items, C4::Members, C4::Reserves, C4::Search
- Koha::Patrons, Koha::Items, Koha::Biblios
- Koha::Database, Koha::Object, Koha::Objects

## Stub Modules

The `stubs/` directory contains placeholder modules for packages not in nixpkgs.
These provide LSP/IDE support only - they have no actual functionality.

### Current Stubs

| Module | Purpose |
|--------|---------|
| Algorithm::Munkres | Hungarian algorithm for optimal assignment |
| Array::Utils | Array utility functions |
| Auth::GoogleAuth | Google Authenticator TOTP |
| DBIx::RunSQL | SQL file execution |
| GD::Barcode::* | Barcode generation |
| JSON::Validator::Schema::OpenAPIv2 | OpenAPI validation |
| Locale::Currency::Format | Currency formatting |
| MARC::* | MARC bibliographic record handling |
| Mojolicious::Plugin::OAuth2 | OAuth2 authentication |
| Net::Stomp | STOMP messaging protocol |
| Net::Z3950::ZOOM | Z39.50 protocol bindings |
| Struct::Diff | Structure comparison |
| WWW::CSRF | CSRF protection |
| ZOOM::* | Z39.50 client library |

## Packages to Add to Nixpkgs (if needed for full functionality)

### High Priority

- **YAZ** - Z39.50 toolkit (C library)
  - Homepage: https://www.indexdata.com/resources/software/yaz/
  - Required for: Z39.50 protocol support (library catalog searches)
  - Would replace: ZOOM.pm stub

- **Net::Z3950::ZOOM** - Perl bindings for YAZ
  - CPAN: https://metacpan.org/pod/Net::Z3950::ZOOM
  - Depends on: YAZ library

- **MARC::Record** and family
  - CPAN: https://metacpan.org/pod/MARC::Record
  - Would replace: MARC/*.pm stubs

### Medium Priority

- **Array::Utils** - CPAN: https://metacpan.org/pod/Array::Utils
- **Algorithm::Munkres** - CPAN: https://metacpan.org/pod/Algorithm::Munkres
- **Struct::Diff** - CPAN: https://metacpan.org/pod/Struct::Diff
- **Locale::Currency::Format** - CPAN: https://metacpan.org/pod/Locale::Currency::Format
- **DBIx::RunSQL** - CPAN: https://metacpan.org/pod/DBIx::RunSQL
- **WWW::CSRF** - CPAN: https://metacpan.org/pod/WWW::CSRF

## Usage

```bash
# Enter the dev shell
nix develop

# Or with direnv
echo "use flake" > .envrc
direnv allow
```

## Adding Missing Modules

1. Check if it exists in nixpkgs:
   ```bash
   nix search nixpkgs#perlPackages.<name>
   ```

2. If in nixpkgs, add to `flake.nix` in the `perlEnv` section

3. If not in nixpkgs, create a stub in `stubs/` following existing patterns

## Testing

```bash
# Find missing modules
nix develop -c perl find_missing.pl

# Test specific module
nix develop -c perl -e 'use C4::Biblio; print "ok\n"'
```
