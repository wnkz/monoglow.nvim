local M = {}

M.url = "https://github.com/hrsh7th/nvim-cmp"

function M.get(c, opts)
  local ret = {
    CmpItemKind = { fg = c.cmp.kind },
    CmpGhostText = { fg = c.exception },
    CmpItemAbbr = { fg = c.fg, bg = c.none },
    CmpItemAbbrMatch = { fg = c.blue2 },
    CmpItemAbbrMatchFuzzy = { fg = c.blue2 },
    CmpItemAbbrDeprecated = { fg = c.cmp.deprecated, bg = c.none, strikethrough = true },
    CmpItemMenu = { fg = c.gray4, bg = c.bg_menu },
  }

  require("monoglow.groups.kinds").kinds(ret, "CmpItemKind%s")
  return ret
end

return M
