# Mono Glow for Zed

A dark, mostly monochrome colorscheme with a touch of glowing.

Part of [monoglow.nvim](https://github.com/wnkz/monoglow.nvim).

## Installation

1. Copy `monoglow.json` to your Zed themes directory:
   - **macOS:** `~/.config/zed/themes/`
   - **Linux:** `~/.config/zed/themes/`
2. Open Zed Settings (`Cmd+,` / `Ctrl+,`)
3. Set your theme:
   ```json
   {
     "theme": "Mono Glow"
   }
   ```
4. Available themes: **Mono Glow**, **Mono Glow Void**, **Mono Glow Lack**

## Recommended Settings

For the best experience with Mono Glow, consider adding this to your Zed settings:

```json
{
  "minimum_contrast_for_highlights": 30.0
}
```

Zed automatically adjusts text brightness to maintain a minimum contrast on highlight backgrounds (default: 45.0). This can be too aggressive for low-contrast themes like Mono Glow, causing text to appear overly bright when highlighting LSP references. Lowering this value preserves the theme's intended appearance.
