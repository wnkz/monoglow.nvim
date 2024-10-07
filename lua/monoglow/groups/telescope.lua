local M = {}

M.url = "https://github.com/nvim-telescope/telescope.nvim"

function M.get(c, opts)
  return {
    TelescopeBorder = { fg = c.border, bg = c.none },
    TelescopeNormal = { fg = c.fg, bg = c.none },

    TelescopeTitle = { fg = c.fg, bg = c.none, bold = true },

    TelescopePromptBorder = { fg = c.border, bg = c.none },
    TelescopePromptTitle = { fg = c.fg, bg = c.none, bold = true },
    TelescopePromptPrefix = { fg = c.glow, bg = c.none, bold = true },
    TelescopePromptCounter = { fg = c.gray6, bg = c.none },

    TelescopeMatching = { fg = c.glow, bg = c.none, bold = true },
    TelescopeSelection = { fg = c.fg, bg = c.selection, bold = true },
    TelescopeSelectionCaret = { fg = c.glow, bg = c.selection },
    TelescopePreviewLine = { bg = c.selection },
  }
end

return M
