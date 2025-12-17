local M = {}

M.url = "https://github.com/Saghen/blink.cmp"

function M.get(c)
  local ret = {
    BlinkCmpKind = { fg = c.cmp.kind },
    BlinkCmpGhostText = { fg = c.exception },
    BlinkCmpLabel = { fg = c.fg, bg = c.none },
    BlinkCmpLabelMatch = { fg = c.blue2 },
    BlinkCmpLabelDeprecated = { fg = c.cmp.deprecated, bg = c.none, strikethrough = true },
    BlinkCmpLabelDetail = { fg = c.gray4, bg = c.none },
    BlinkCmpLabelDescription = { fg = c.gray5, bg = c.none },
    BlinkCmpSource = { fg = c.gray4, bg = c.none },
    BlinkCmpMenu = { fg = c.fg, bg = c.bg_menu },
    BlinkCmpMenuBorder = { fg = c.border, bg = c.bg_menu },
    BlinkCmpDoc = { fg = c.fg, bg = c.bg_popup },
    BlinkCmpDocBorder = { fg = c.border, bg = c.bg_popup },
    BlinkCmpSignatureHelp = { fg = c.fg, bg = c.bg_popup },
    BlinkCmpSignatureHelpBorder = { fg = c.border, bg = c.bg_popup },
  }

  require("monoglow.groups.kinds").kinds(ret, "BlinkCmpKind%s")
  return ret
end

return M
