local M = {}

function M.get()
  local colors, config = require("monoglow.colors").setup()

  local hl = {}

  hl.normal = {
    a = { bg = colors.statusline, fg = colors.gray7 },
    b = { bg = colors.gray2, fg = colors.fg },
    c = { bg = colors.statusline, fg = colors.gray6 },
  }

  hl.insert = {
    a = { bg = colors.glow, fg = colors.statusline },
    b = { bg = colors.gray2, fg = colors.fg },
    c = { bg = colors.statusline, fg = colors.gray6 },
  }

  hl.command = {
    a = { bg = colors.glow, fg = colors.statusline },
    b = { bg = colors.gray2, fg = colors.fg },
    c = { bg = colors.statusline, fg = colors.gray6 },
  }

  hl.visual = {
    a = { bg = colors.gray9, fg = colors.statusline },
    b = { bg = colors.gray2, fg = colors.fg },
    c = { bg = colors.statusline, fg = colors.gray6 },
  }

  hl.replace = {
    a = { bg = colors.gray9, fg = colors.statusline },
    b = { bg = colors.gray2, fg = colors.fg },
    c = { bg = colors.statusline, fg = colors.gray6 },
  }

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
