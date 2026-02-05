# koha-dev-nix

Nix development environment for [Koha ILS](https://koha-community.org/) - provides Perl dependencies for PerlNavigator LSP support.

## Purpose

This is **not** a replacement for [koha-testing-docker](https://gitlab.com/koha-community/koha-testing-docker). It provides:

- Perl environment with Koha's dependencies resolved
- PerlNavigator LSP integration for IDE support
- Cross-platform (macOS, Linux, WSL)

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
nix develop --extra-experimental-features 'nix-command flakes'

# Or enable flakes permanently in ~/.config/nix/nix.conf:
# experimental-features = nix-command flakes
```

## Editor Setup

### VS Code with PerlNavigator

1. Install the PerlNavigator extension
2. Configure settings:
   ```json
   {
     "perlnavigator.perlPath": "perl"
   }
   ```
3. Open VS Code from within `nix develop` shell

### Neovim with nvim-lspconfig

```lua
require('lspconfig').perlnavigator.setup{
  cmd = { "perlnavigator" },
  -- perlnavigator is in PATH from nix develop
}
```

## With direnv

```bash
echo "use flake" > .envrc
direnv allow
```

## Structure

```
koha-dev-nix/
├── flake.nix       # Nix flake with Perl dependencies
├── flake.lock      # Locked dependency versions
├── stubs/          # Stub modules for packages not in nixpkgs
├── find_missing.pl # Script to find missing modules
├── TODO.md         # Known issues and future work
└── README.md       # This file
```

## See Also

- [koha-testing-docker](https://gitlab.com/koha-community/koha-testing-docker) - Full Koha dev/test environment
- [Koha Community](https://koha-community.org/)
