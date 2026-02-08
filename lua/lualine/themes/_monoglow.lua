local util = require("monoglow.util")

local M = {}

---@param style? string
function M.get(style)
  if not style and vim.g.colors_name then
    style = vim.g.colors_name:match("^monoglow%-(.+)$")
  end
  local colors, config = require("monoglow.colors").setup({ style = style })

  local hl = {}

  hl.normal = {
    a = { bg = colors.mode.normal.bg, fg = colors.mode.normal.fg },
    b = { bg = util.darken(colors.bg_statusline, 0.5), fg = colors.gray7 },
    c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
  }

  hl.insert = {
    a = { bg = colors.mode.insert.bg, fg = colors.mode.insert.fg },
    b = { bg = util.darken(colors.bg_statusline, 0.5), fg = colors.gray7 },
    c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
  }

  hl.command = hl.insert

  hl.visual = {
    a = { bg = colors.mode.visual.bg, fg = colors.mode.visual.fg },
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
