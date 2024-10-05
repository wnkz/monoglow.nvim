local M = {}

function M.setup(opts)
  opts = require("monoglow.config").extend(opts)
  local colors = {
    none = "NONE",

    fg = "#c0c0c0",
    bg = "#1c1c1c",

    glow = "#1bfd9c",

    -- Nvim*
    n_light_blue = "#a6dbff", -- NvimLightBlue
    n_light_cyan = "#8cf8f7", -- NvimLightCyan
    n_light_green = "#b3f6c0", -- NvimLightGreen
    n_light_magenta = "#ffcaff", -- NvimLightMagenta
    n_light_red = "#ffc0b9", -- NvimLightRed
    n_light_yellow = "#fce094", -- NvimLightYellow

    white = "#ffffff",
    gray1 = "#f1f1f1",
    gray2 = "#e6e6e6",
    gray3 = "#e1e1e1",
    gray4 = "#d1d1d1",
    gray5 = "#b1b1b1",
    gray6 = "#a1a1a1",
    gray7 = "#585858",
    gray8 = "#404040",
    gray9 = "#3c3c3c",
    gray10 = "#303030",
    gray11 = "#272727",
    gray12 = "#1e1e1e",
    black = "#000000",

    blue1 = "#b2d8d8",
    blue2 = "#66b2b2",

    -- color pool
    -- #bdfe58, #4b8902, #c0c0c0, #789978
  }

  colors.diff = {
    add = "#baffc9",
    change = "#ffffba",
    delete = "#ffb3ba",
  }

  colors.error = colors.n_light_red
  colors.warning = colors.n_light_yellow
  colors.info = colors.n_light_cyan
  colors.hint = colors.n_light_blue

  return colors, opts
end

return M
