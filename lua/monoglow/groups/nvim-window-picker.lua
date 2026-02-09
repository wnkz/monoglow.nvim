local M = {}

M.url = "https://github.com/s1n7ax/nvim-window-picker"

---@type monoglow.HighlightsFn
function M.get(c, opts)
  return {
    WindowPickerStatusLine = { fg = c.glow, bg = c.gray3 },
    WindowPickerStatusLineNC = { fg = c.glow, bg = c.gray3 },
    WindowPickerWinBar = "WindowPickerStatusLine",
    WindowPickerWinBarNC = "WindowPickerStatusLineNC",
  }
end

return M
