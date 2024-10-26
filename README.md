# 🎆 Mono Glow

A dark, mostly monochrome colorscheme with a touch of glowing.

In simpler terms, it's like [lackluster.nvim](https://github.com/slugbyte/lackluster.nvim) and [darkvoid.nvim](https://github.com/Aliqyan-21/darkvoid.nvim) had a baby.

![zig](https://github.com/user-attachments/assets/d8766bcf-ff92-4304-b135-3b32cc74bfc3)
![modes](https://github.com/user-attachments/assets/471357fe-3c28-470c-9d36-360f2ea175e3)

> [!NOTE]
> More 📷 [screenshots here](SCREENSHOTS.md)

## ✨ Features

- Supports the latest [Neovim](https://github.com/neovim/neovim)
  [0.9.0](https://github.com/neovim/neovim/releases/tag/v0.9.0) features.
- Terminal colors.
- Supports ~all major~ plugins.

## 📦 Installation

Install the theme with your preferred package manager, such as
[folke/lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "wnkz/monoglow.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
}
```

## 🚀 Usage

```lua
vim.cmd[[colorscheme monoglow]]
```

```vim
colorscheme monoglow

" There are also colorschemes for the different styles.
colorscheme monoglow-z
colorscheme monoglow-lack
colorscheme monoglow-void
```

## Acknowledgement

- [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [Aliqyan-21/darkvoid.nvim](https://github.com/Aliqyan-21/darkvoid.nvim)
- [slugbyte/lackluster.nvim](https://github.com/slugbyte/lackluster.nvim)
- [fcancelinha/nordern.nvim](https://github.com/fcancelinha/nordern.nvim)
