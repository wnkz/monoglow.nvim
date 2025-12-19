# Mono Glow for OpenCode

Part of [monoglow.nvim](https://github.com/wnkz/monoglow.nvim).

## Installation

1. Copy the desired `.json` theme file(s) to your OpenCode themes directory:
   ```sh
   mkdir -p ~/.config/opencode/themes
   cp monoglow-z.json ~/.config/opencode/themes/
   ```
2. Select the theme in OpenCode using the `/theme` command, or set it in your config:
   ```json
   {
     "$schema": "https://opencode.ai/config.json",
     "theme": "monoglow-z"
   }
   ```
3. Available themes: `monoglow-z`, `monoglow-lack`, `monoglow-void`

## Notes

**Built-in syntax highlighting**: OpenCode uses the theme's `error` color for built-in
syntax tokens (`console`, `len`, `echo`, etc.). This is an OpenCode design choice.
To maintain monoglow's grayscale aesthetic, we use `luster` (#deeeed) - a subtle
light teal-ish white that provides distinction without breaking the monochrome look.
