# Mono Glow for Obsidian

A dark, mostly monochrome colorscheme with a touch of glowing.

Part of [monoglow.nvim](https://github.com/wnkz/monoglow.nvim).

## Installation

1. Create a folder named `Mono Glow` in your vault's themes directory:
   `<vault>/.obsidian/themes/Mono Glow/`
2. Copy `manifest.json` and `theme.css` into it.
3. In Obsidian, open **Settings → Appearance → Themes** and select **Mono Glow**.

The theme supports both modes. Toggle **Settings → Appearance → Base color scheme**
between dark and light to switch between **Mono Glow** and **Mono Glow Light**.

## Variants

With the [Style Settings](https://github.com/mgmeyers/obsidian-style-settings)
plugin installed, open **Settings → Style Settings → Mono Glow** to choose the dark
variant:

- **Mono Glow** (default)
- **Mono Glow Void**
- **Mono Glow Lack**

## Accent color

The glow color is set through Obsidian's accent color. To use a different color,
pick a custom accent under **Settings → Appearance → Accent color**. Links, tags,
checkboxes and other glow elements update to match.

## Development

`theme.css` is generated. Do not edit it by hand. Change
[`lua/monoglow/extra/obsidian.lua`](../../lua/monoglow/extra/obsidian.lua) and run
`./scripts/build` from the repository root.

To lint the generated CSS against Obsidian's theme review rules:

```sh
npm install
npm run lint
```
