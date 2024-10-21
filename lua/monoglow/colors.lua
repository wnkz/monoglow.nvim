local M = {}

function M.setup(opts)
  opts = require("monoglow.config").extend(opts)
  local colors = {
    none = "NONE",

    bright_green = "#1bfd9c",

    -- Nvim*
    light_blue = "#a6dbff", -- NvimLightBlue
    light_cyan = "#8cf8f7", -- NvimLightCyan
    light_green = "#b3f6c0", -- NvimLightGreen
    light_magenta = "#ffcaff", -- NvimLightMagenta
    light_red = "#ffc0b9", -- NvimLightRed
    light_yellow = "#fce094", -- NvimLightYellow

    -- Lackluster grays
    black = "#000000",
    gray1 = "#080808",
    gray2 = "#191919",
    gray3 = "#2a2a2a",
    gray4 = "#444444",
    gray5 = "#555555",
    gray6 = "#7a7a7a",
    gray7 = "#aaaaaa",
    gray8 = "#cccccc",
    gray9 = "#dddddd",
    gray10 = "#f1f1f1",
    white = "#ffffff",

    -- Darkvoid grays
    -- black = "#000000",
    -- gray1 = "#1e1e1e",
    -- gray2 = "#2a2a2a",
    -- gray3 = "#303030",
    -- gray4 = "#404040",
    -- gray5 = "#585858",
    -- gray6 = "#a1a1a1",
    -- gray7 = "#b1b1b1",
    -- gray8 = "#d1d1d1",
    -- gray9 = "#e1e1e1",
    -- gray10 = "#f1f1f1",
    -- white = "#ffffff",

    blue1 = "#b2d8d8",
    blue2 = "#66b2b2",
  }

  -- NOTE: kept as a tribute to lackluster
  colors.lack = "#708090"
  colors.luster = "#deeeed"

  -- NOTE: special colors
  colors.fg = "#c0c0c0"
  colors.bg = "#1c1c1c"
  colors.bg_menu = "#1f1f1f"
  colors.bg_popup = "#202020"

  colors.glow = colors.bright_green

  colors.cur_line_nr = colors.gray7
  colors.line_nr = colors.gray4
  colors.statusline = "#202020"

  colors.keyword = "#727272"
  colors.comment = "#474747"
  colors.exception = "#505050"
  colors.param = "#8e8e8e"
  colors.whitespace = "#202020"
  colors.icon = colors.gray5
  colors.title = colors.gray5
  colors.visual = "#555555"
  colors.selection = colors.gray3
  colors.border = colors.gray4

  -- NOTE: common colors aliases
  colors.syntax = {
    boolean = colors.blue2,
    builtin = colors.gray5,
    comment = colors.comment,
    const = colors.gray7,
    const_builtin = colors.gray6,
    func_call = colors.gray6,
    func_def = colors.gray8,
    func_param = colors.param,
    keyword = colors.keyword,
    keyword_return = colors.exception,
    keyword_exception = colors.exception,
    punctuation = colors.gray8,
    special = colors.gray10,
    string = colors.gray7,
    string_escape = colors.lack,
    tag = colors.gray5,
    type = colors.gray7,
    type_def = colors.gray8,
    type_primitive = colors.gray8,
    var = colors.gray9,
    var_member = colors.gray8,
  }

  colors.fs = {
    dir = colors.gray7,
    file = colors.gray8,
    exec = colors.blue2,
    link = colors.luster,
    binary_data = colors.gray6,
    socket = colors.gray6,
  }

  colors.git = {
    add = "#baffc9",
    change = "#ffffba",
    delete = "#ffb3ba",
  }

  colors.cmp = {
    kind = colors.gray7,
    snippet = colors.lack,
    deprecated = colors.gray4,
  }

  colors.diff = colors.git

  colors.error = colors.light_red
  colors.warning = colors.light_yellow
  colors.info = colors.light_cyan
  colors.hint = colors.luster
  colors.todo = colors.lack

  return colors, opts
end

return M
