# AGENTS.md

## Project Overview

Monochrome Neovim colorscheme with some extras.

## Project Structure
- `lua/monoglow/colors/` - Color palettes per style (z, lack, void)
- `lua/monoglow/groups/` - Highlight definitions (base, treesitter, plugins)
- `lua/monoglow/extra/` - Generators for external apps (kitty, ghostty, etc.)
- `extras/` - Generated files (do not edit manually, run `./scripts/build`)

## Commands
- Build extras: `./scripts/build`
- Test in Neovim: `nvim -u tests/minit.lua`

## Code Style
- Format: StyLua (2 spaces, double quotes) - see `.stylua.toml`
