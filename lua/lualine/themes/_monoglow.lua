local util = require("monoglow.util")

local M = {}

function M.get()
  local colors, config = require("monoglow.colors").setup()

  local hl = {}

  hl.normal = {
    a = { bg = colors.gray12, fg = colors.fg },
    b = { bg = colors.gray10, fg = colors.fg },
    c = { bg = colors.gray11, fg = colors.fg },
  }

  hl.insert = {
    a = { bg = colors.gray12, fg = colors.gray1 },
    b = { bg = colors.gray10, fg = colors.fg },
    c = { bg = colors.gray11, fg = colors.fg },
  }

  hl.command = {
    a = { bg = colors.glow, fg = colors.gray12 },
    b = { bg = colors.gray10, fg = colors.fg },
    c = { bg = colors.gray11, fg = colors.fg },
  }

  hl.visual = {
    a = { bg = colors.gray12, fg = colors.glow },
    b = { bg = colors.gray10, fg = colors.fg },
    c = { bg = colors.gray11, fg = colors.fg },
  }

  hl.replace = {
    a = { bg = colors.gray12, fg = colors.fg },
    b = { bg = colors.gray10, fg = colors.fg },
    c = { bg = colors.gray11, fg = colors.fg },
  }

  hl.terminal = {
    a = { bg = colors.gray12, fg = colors.fg },
    b = { bg = colors.gray10, fg = colors.fg },
    c = { bg = colors.gray11, fg = colors.fg },
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
