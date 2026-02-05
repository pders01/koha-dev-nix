# koha-dev-nix

Nix development environment for [Koha ILS](https://koha-community.org/) - provides Perl dependencies for PerlNavigator LSP support.

**Status: 99.8% module coverage** (1243/1245 Koha modules load successfully)

## Purpose

This is **not** a replacement for [koha-testing-docker](https://gitlab.com/koha-community/koha-testing-docker). It provides:

- Perl environment with Koha's dependencies resolved
- PerlNavigator LSP integration for IDE support
- Cross-platform (macOS, Linux, WSL)
- Developer experience with helpful shell commands

It does **not** provide:

- Running Koha instance
- Database, Memcached, Elasticsearch
- Apache/Plack web server

## Quick Start

```bash
# Clone next to your koha checkout
cd ~/Projects
git clone <this-repo> koha-dev-nix
git clone <koha-repo> koha  # if not already present

# Enter the dev shell
cd koha-dev-nix
nix develop

# If flakes not enabled, use:
nix develop --extra-experimental-features 'nix-command flakes'
```

You should see:

```
╭─────────────────────────────────────────────╮
│  Koha Development Environment               │
│  Module coverage: 1243/1245 (99.8%)         │
╰─────────────────────────────────────────────╯

Commands:
  koha-test        Run full module test
  koha-check       Test specific module (e.g., koha-check C4::Biblio)
  koha-missing     Find missing external dependencies
  koha-stubs       List all stub modules
```

## Shell Commands

Once inside `nix develop`:

| Command | Description |
|---------|-------------|
| `koha-test` | Run the full module test suite (tests all 1245 modules) |
| `koha-check C4::Biblio` | Test if a specific module loads |
| `koha-missing` | Find missing external dependencies |
| `koha-stubs` | List all stub modules |

## Verify Installation

```bash
# Run the full test
koha-test

# Or test a specific module
koha-check Koha::Patrons
koha-check C4::Biblio
koha-check Koha::REST::V1
```

## Editor Setup

### VS Code with PerlNavigator

1. Install the [PerlNavigator extension](https://marketplace.visualstudio.com/items?itemName=bscan.perlnavigator)
2. **Important**: Open VS Code from within the `nix develop` shell:
   ```bash
   cd koha-dev-nix
   nix develop
   code ../koha
   ```
3. Configure `.vscode/settings.json` in your Koha directory:
   ```json
   {
     "perlnavigator.perlPath": "perl",
     "perlnavigator.includePaths": [".", "lib"]
   }
   ```

### Neovim with nvim-lspconfig

```lua
-- In your LSP config
require('lspconfig').perlnavigator.setup{
  cmd = { "perlnavigator" },
  settings = {
    perlnavigator = {
      includePaths = { ".", "lib" }
    }
  }
}
```

**Important**: Start Neovim from within the `nix develop` shell so `perlnavigator` is in PATH.

### Emacs with eglot/lsp-mode

```elisp
;; With eglot
(add-to-list 'eglot-server-programs '(perl-mode . ("perlnavigator")))

;; With lsp-mode
(setq lsp-perlnavigator-executable "perlnavigator")
```

## With direnv (Recommended)

For automatic shell activation:

```bash
# In koha-dev-nix directory
echo "use flake" > .envrc
direnv allow
```

Now the environment activates automatically when you `cd` into the directory.

## Directory Structure

```
~/Projects/
├── koha/              # Koha source code
└── koha-dev-nix/      # This repo (must be sibling to koha/)
    ├── flake.nix      # Nix flake with Perl dependencies
    ├── flake.lock     # Locked dependency versions
    ├── stubs/         # Stub modules for packages not in nixpkgs
    ├── test_all_modules.pl
    ├── find_missing.pl
    ├── TODO.md
    └── README.md
```

## Adding Missing Modules

If you encounter a missing module:

### 1. Check if it's in nixpkgs

```bash
nix search nixpkgs#perlPackages.<ModuleName>
# Or
nix eval --json 'nixpkgs#perlPackages' --apply 'ps: builtins.hasAttr "ModuleName" ps'
```

### 2. If in nixpkgs, add to flake.nix

Edit `flake.nix` and add the package to the `perlEnv` section:

```nix
perlEnv = pkgs.perl.withPackages (ps: with ps; [
  # ... existing packages ...
  NewModuleName  # Add here
]);
```

### 3. If not in nixpkgs, create a stub

```bash
# Create directory structure
mkdir -p stubs/Some/Module

# Create stub file
cat > stubs/Some/Module/Name.pm << 'EOF'
# STUB: Some::Module::Name is not in nixpkgs
package Some::Module::Name;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless {}, shift }
# Add other required methods

1;
EOF
```

### 4. Test and commit

```bash
koha-check Some::Module::Name
koha-test  # Verify nothing broke
git add stubs/Some/Module/Name.pm
git commit -m "feat: add Some::Module::Name stub"
```

## Troubleshooting

### "unable to locate Koha configuration file koha-conf.xml"

This warning is **expected and harmless**. The LSP environment doesn't need Koha's runtime config.

### "Base class package X is empty"

The module needs a stub file for inheritance. Create a stub in `stubs/` following the pattern in existing stubs. See `stubs/HTTP/OAI/` for examples of inheritance-compatible stubs.

### Module still not found after adding to flake.nix

1. Exit and re-enter `nix develop`
2. Check the exact package name in nixpkgs (case-sensitive)

### Two modules that will always fail

- `C4::Auth_with_ldap` - Requires LDAP config at compile time
- `C4::SIP::SIPServer` - Requires Log4perl config at compile time

These have compile-time dependencies on `koha-conf.xml` and cannot be fixed with stubs.

## Known Limitations

- Some modules are stubs with no actual functionality (see `TODO.md`)
- Runtime features (database, caching, etc.) are not available
- 2 modules (0.2%) cannot load without koha-conf.xml

## See Also

- [koha-testing-docker](https://gitlab.com/koha-community/koha-testing-docker) - Full Koha dev/test environment
- [Koha Community](https://koha-community.org/)
- [PerlNavigator](https://github.com/bscan/PerlNavigator) - Perl Language Server
