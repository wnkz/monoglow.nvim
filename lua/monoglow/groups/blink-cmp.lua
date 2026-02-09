local M = {}

M.url = "https://github.com/Saghen/blink.cmp"

---@type monoglow.HighlightsFn
function M.get(c, opts)
  local ret = {
    BlinkCmpKind = { fg = c.cmp.kind },
    BlinkCmpGhostText = { fg = c.special.exception },
    BlinkCmpLabel = { fg = c.fg, bg = c.none },
    BlinkCmpLabelMatch = { fg = c.blue2 },
    BlinkCmpLabelDeprecated = { fg = c.cmp.deprecated, bg = c.none, strikethrough = true },
    BlinkCmpSource = { fg = c.gray4, bg = c.none },
  }

  require("monoglow.groups.kinds").kinds(ret, "BlinkCmpKind%s")
  return ret
end

return M
