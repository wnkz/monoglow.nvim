local M = {}

M.url = "https://github.com/Saghen/blink.cmp"

function M.get(c)
  local ret = {
    BlinkCmpKind = { fg = c.cmp.kind },
    BlinkCmpGhostText = { fg = c.exception },
    BlinkCmpLabel = { fg = c.fg, bg = c.none },
    BlinkCmpLabelMatch = { fg = c.blue2 },
    BlinkCmpLabelDeprecated = { fg = c.cmp.deprecated, bg = c.none, strikethrough = true },
    BlinkCmpMenu = { fg = c.comment, bg = c.none },
    BlinkCmpMenuBorder = { fg = c.border, bg = c.none },
    BlinkCmpDocBorder = { fg = c.border, bg = c.none },
    BlinkCmpSignatureHelpBorder = { fg = c.border, bg = c.none },
  }

  require("monoglow.groups.kinds").kinds(ret, "BlinkCmpKind%s")
  return ret
end

return M
