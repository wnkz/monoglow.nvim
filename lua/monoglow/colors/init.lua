local util = require("monoglow.util")

local M = {}

---@type table<string, Palette|fun(opts:monoglow.Config):Palette>
M.styles = setmetatable({}, {
  __index = function(_, style)
    return vim.deepcopy(util.mod("monoglow.colors." .. style))
  end,
})

---@param opts? monoglow.Config
function M.setup(opts)
  opts = require("monoglow.config").extend(opts)

  local palette = M.styles[opts.style]
  if type(palette) == "function" then
    palette = palette(opts) --[[@as Palette]]
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = palette

  util.bg = colors.bg
  util.fg = colors.fg

  colors.none = "NONE"

  colors.diff = {
    add = util.darken(colors.git.add, 0.60),
    delete = util.darken(colors.git.delete, 0.60),
    change = colors.gray6,
    text = colors.gray5,
  }

  colors.black = util.blend_bg(colors.bg, 0.8, "#000000")

  colors.bg_menu = util.lighten(colors.bg, 0.95)
  colors.bg_popup = util.lighten(colors.bg, 0.955)
  colors.border = colors.gray4
  colors.fg_sidebar = colors.gray6
  colors.fg_gutter = colors.gray4
  colors.bg_statusline = util.lighten(colors.bg, 0.97)

  colors.cur_line = util.lighten(colors.bg, 0.92)
  colors.cur_line_nr = colors.gray7
  colors.lsp_ref = util.lighten(colors.cur_line, 0.97)
  colors.visual = util.lighten(colors.cur_line, 0.95)
  colors.selection = colors.cur_line

  colors.special = colors.special or {}
  colors.special = vim.tbl_deep_extend("keep", colors.special, {
    comment = util.darken(colors.gray4, 0.95),
    exception = util.darken(colors.gray5, 0.92),
    keyword = util.darken(colors.gray6, 0.90),
    param = util.lighten(colors.gray5, 0.70),
    property = util.darken(colors.gray7, 0.80),
    whitespace = util.lighten(colors.gray2, 0.85),
  })

  colors.icon = colors.gray5
  colors.title = colors.gray5

  colors.syntax = {
    boolean = colors.blue2,
    builtin = colors.gray5,
    comment = colors.special.comment,
    const = colors.gray7,
    const_builtin = colors.gray6,
    func_call = colors.gray6,
    func_def = colors.gray8,
    func_param = colors.special.param,
    keyword = colors.special.keyword,
    keyword_exception = colors.special.exception,
    keyword_return = colors.special.exception,
    property = colors.special.property,
    punctuation = colors.gray8,
    special = colors.gray10,
    string = colors.gray7,
    string_escape = colors.lack,
    tag = colors.gray5,
    type = colors.gray7,
    type_def = colors.gray8,
    type_primitive = colors.gray7,
    var = colors.gray8,
    var_member = colors.gray7,
  }

  colors.fs = {
    dir = colors.gray7,
    file = colors.gray8,
    exec = colors.blue2,
    link = colors.luster,
    binary_data = colors.gray6,
    socket = colors.gray6,
  }

  colors.cmp = {
    kind = colors.gray7,
    snippet = colors.lack,
    deprecated = colors.gray4,
  }

  colors.error = colors.light_red
  colors.warning = colors.light_yellow
  colors.info = colors.light_cyan
  colors.hint = colors.luster
  colors.todo = colors.lack

  -- NOTE:
  -- inspirated from
  -- https://github.com/PieterHeijman/terminal-color-themes/blob/master/movies/Psycho.json
  ---@class TerminalColors
  colors.terminal = {
    black = colors.gray3,
    black_bright = util.lighten(colors.gray3, 0.80),
    red = colors.luster,
    red_bright = colors.lack,
    green = colors.glow,
    green_bright = util.brighten(colors.glow),
    yellow = util.darken(colors.gray9, 0.80),
    yellow_bright = colors.gray9,
    blue = colors.gray6,
    blue_bright = colors.gray7,
    magenta = colors.blue2,
    magenta_bright = util.brighten(colors.blue2),
    cyan = colors.gray8,
    cyan_bright = util.lighten(colors.gray8, 0.80, colors.gray10),
    white = colors.gray10,
    white_bright = colors.white,
  }

  opts.on_colors(colors)

  return colors, opts
end

return M
