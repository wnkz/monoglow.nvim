# Mono Glow for WezTerm

Part of [monoglow.nvim](https://github.com/wnkz/monoglow.nvim).

## Installation

1. Copy the `.toml` files to your WezTerm colors directory:
   - **macOS/Linux:** `~/.config/wezterm/colors/`
   - **Windows:** `colors/` subdirectory next to `wezterm.exe`
   - Or use `config.color_scheme_dirs` in your `wezterm.lua` to specify a custom path
2. Add to your `wezterm.lua`:
   ```lua
   config.color_scheme = "Mono Glow"
   ```
3. Available themes:
   - `monoglow_z.toml` — `config.color_scheme = "Mono Glow"`
   - `monoglow_lack.toml` — `config.color_scheme = "Mono Glow Lack"`
   - `monoglow_void.toml` — `config.color_scheme = "Mono Glow Void"`
