#!/usr/bin/env -S nvim -l

vim.env.LAZY_STDPATH = ".tests"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

local spec = {
  {
    dir = vim.uv.cwd(),
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("monoglow").setup(opts)
      vim.cmd.colorscheme("monoglow")
    end,
  },
}

-- Add treesitter when TS=1 environment variable is set
if vim.env.TS == "1" then
  table.insert(spec, {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "css",
          "html",
          "javascript",
          "lua",
          "python",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "vue",
          "zig",
        },
        highlight = { enable = true },
      })
    end,
  })
end

-- Setup lazy
require("lazy.minit").setup({ spec = spec })
