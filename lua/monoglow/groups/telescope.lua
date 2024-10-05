local M = {}

M.url = "https://github.com/nvim-telescope/telescope.nvim"

function M.get(c, opts)
  return {
    TelescopeBorder = { fg = c.gray7, bg = c.none },
    TelescopeNormal = { fg = c.fg, bg = c.none },

    TelescopeTitle = { fg = c.gray3, bg = c.none, bold = true },

    TelescopePromptBorder = { fg = c.gray4, bg = c.none },
    TelescopePromptTitle = { fg = c.gray1, bg = c.none, bold = true },
    TelescopePromptPrefix = { fg = c.glow, bg = c.none, bold = true },
    TelescopePromptCounter = { fg = c.gray2, bg = c.none },

    TelescopeMatching = { fg = c.glow, bg = c.none, bold = true },
    TelescopeSelection = { fg = c.fg, bg = c.gray10, bold = true },
    TelescopeSelectionCaret = { fg = c.glow, bg = c.gray10 },
  }
end

return M
