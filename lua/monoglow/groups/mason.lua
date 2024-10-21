local M = {}

M.url = "https://github.com/williamboman/mason.nvim"

function M.get(c, opts)
  return {
    MasonHeader = { fg = c.black, bg = c.glow },
    MasonHeaderSecondary = { fg = c.bg, bg = c.blue2 },
    MasonHighlight = { fg = c.blue2 },
    MasonHighlightBlock = { fg = c.bg, bg = c.blue2 },
    MasonHighlightBlockBold = { fg = c.bg, bg = c.blue2, bold = true },
    MasonHighlightSecondary = { fg = c.glow },
    MasonHighlightBlockSecondary = { fg = c.bg, bg = c.glow },
    MasonHighlightBlockBoldSecondary = { fg = c.black, bg = c.glow, bold = true },
    MasonMuted = { fg = c.gray6 },
    MasonMutedBlock = { fg = c.bg, bg = c.gray6 },
    MasonMutedBlockBold = { fg = c.bg, bg = c.gray6, bold = true },
  }
end

return M
