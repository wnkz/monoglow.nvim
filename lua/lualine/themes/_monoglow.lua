local util = require("monoglow.util")

local M = {}

---@param style? string
function M.get(style)
  local colors, config = require("monoglow.colors").setup({ style = style })

  local hl = {}

  hl.normal = {
    a = { bg = util.darken(colors.bg_statusline, 0.2), fg = colors.gray8 },
    b = { bg = util.darken(colors.bg_statusline, 0.5), fg = colors.gray7 },
    c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
  }

  hl.insert = {
    a = { bg = colors.glow, fg = colors.black },
    b = { bg = util.darken(colors.bg_statusline, 0.5), fg = colors.gray7 },
    c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
  }

  hl.command = hl.insert

  hl.visual = {
    a = { bg = colors.gray9, fg = colors.black },
    b = { bg = util.darken(colors.bg_statusline, 0.5), fg = colors.gray7 },
    c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
  }

  hl.replace = hl.visual

  hl.inactive = {
    a = { bg = colors.bg, fg = colors.bg },
    b = { bg = colors.bg, fg = colors.bg },
    c = { bg = colors.bg, fg = colors.bg },
  }

  if config.lualine_bold then
    for _, mode in pairs(hl) do
      mode.a.gui = "bold"
    end
  end

  return hl
end

return M
