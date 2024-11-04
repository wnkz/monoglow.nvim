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
- Supports ~all major~ plugins (see below).

> [!NOTE]
> Currently available Plugins and Extras are mostly based on what I use but feel free
> to open an issue or a PR to suggest a new one!

### 🎨 Supported Plugins

Have a look at [this file](lua/monoglow/groups/init.lua) while I'll probably reuse what [folke](https://github.com/folke) did to keep the table up-to-date.

### 🍭 Extras

Have a look at [this file](lua/monoglow/extra/init.lua) while I'll probably reuse what [folke](https://github.com/folke) did to keep the table up-to-date.

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

## 🪓 Overriding Colors & Highlight Groups

How the highlight groups are calculated:

1. `colors` are determined based on your configuration, with the ability to
   override them using `config.on_colors(colors)`.
1. These `colors` are utilized to generate the highlight groups.
1. `config.on_highlights(highlights, colors)` can be used to override highlight
   groups.

For default values of `colors` and `highlights`, please consult the
[z](extras/lua/monoglow_z.lua),
[lack](extras/lua/monoglow_moon.lua), and
[void](extras/lua/monoglow_night.lua) themes.

<details>
  <summary>Changing Colors</summary>

```lua
require("monoglow").setup({
  -- Change the "glow" color
  on_colors = function(colors)
    colors.glow = "#fd1b7c"
  end
})
```

![zig-pink](https://github.com/user-attachments/assets/bbc45014-0904-4e76-ad73-1a8a6fd24dad)

</details>

## 🍭 Extras

Extra color configs for such as can be found in [extras](extras/).
To use them, refer to their respective documentation.

![kitty](https://github.com/user-attachments/assets/bd72b01d-3f41-4d8c-bc62-3580f92db815)

## 🔥 Contributing

Pull requests are welcome.

## About

To build the colorscheme, I took everthing I liked about the "colors" of [slugbyte/lackluster.nvim](https://github.com/slugbyte/lackluster.nvim),
I added the amazing touch of glow and bright operators from [Aliqyan-21/darkvoid.nvim](https://github.com/Aliqyan-21/darkvoid.nvim),
and I used [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) for the code structure.

## License

This project is licensed under the Apache License, Version 2.0. See the [LICENSE](LICENSE) file for details.

### Third-Party Acknowledgments

- Portions of this project include code derived from [tokyonight.nvim](https://github.com/folke/tokyonight.nvim), which is licensed under the Apache License, Version 2.0.
- Inspiration for colors and arrangement comes from [lackluster.nvim](https://github.com/slugbyte/lackluster.nvim) and [darkvoid.nvim](https://github.com/Aliqyan-21/darkvoid.nvim), both licensed under the MIT License.

See the [NOTICE](NOTICE) file for attributions and details.
