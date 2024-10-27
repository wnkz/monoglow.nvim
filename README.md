# 🎆 Mono Glow

A dark, mostly monochrome colorscheme with a touch of glowing.

![zig](https://github.com/user-attachments/assets/31d2c5d1-db25-4b63-b2ad-b6be7abc678c)
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

## About

To build the colorscheme, I took everthing I liked about the "colors" of [slugbyte/lackluster.nvim](https://github.com/slugbyte/lackluster.nvim),
I added the amazing touch of glow and bright operators from [Aliqyan-21/darkvoid.nvim](https://github.com/Aliqyan-21/darkvoid.nvim),
and I used [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) for the code structure.

## Acknowledgement

- [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [Aliqyan-21/darkvoid.nvim](https://github.com/Aliqyan-21/darkvoid.nvim)
- [slugbyte/lackluster.nvim](https://github.com/slugbyte/lackluster.nvim)
- [fcancelinha/nordern.nvim](https://github.com/fcancelinha/nordern.nvim)
