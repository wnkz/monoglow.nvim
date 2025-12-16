#!/usr/bin/env -S nvim -l
-- Minimal config for screenshot generation
-- Includes: colorscheme, treesitter, lualine
-- Usage: nvim -u tests/screenshot_init.lua <file>

vim.env.LAZY_STDPATH = ".tests"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

local spec = {
  -- Monoglow colorscheme
  {
    dir = vim.uv.cwd(),
    lazy = false,
    priority = 1000,
    opts = {
      on_colors = function(colors)
        local custom_glow = os.getenv("MONOGLOW_GLOW")
        if custom_glow then
          colors.glow = custom_glow
        end
      end,
    },
    config = function(_, opts)
      require("monoglow").setup(opts)
      -- Don't set colorscheme here - let the tape file do it
    end,
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "lua",
          "python",
          "rust",
          "zig",
        },
        highlight = { enable = true },
      })
    end,
  },

  -- Lualine for statusline (optional, comment out if not needed)
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "monoglow",
          icons_enabled = false,
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
}

-- Editor settings for clean screenshots
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.showmode = false -- lualine shows mode
vim.opt.laststatus = 2
vim.opt.cmdheight = 0 -- Hide command bar for clean screenshots

-- Setup lazy
require("lazy.minit").setup({ spec = spec })
