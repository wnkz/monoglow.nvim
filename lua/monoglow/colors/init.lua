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

  ---@class ColorScheme: Palette
  ---@field none string Special value for transparent/no color
  ---@field black string Darkened background for contrast
  -- UI backgrounds
  ---@field bg_menu string Background for menus
  ---@field bg_popup string Background for popups/floats
  ---@field bg_statusline string Background for statusline
  ---@field border string Border color for windows/floats
  ---@field fg_sidebar string Foreground for sidebars
  ---@field fg_gutter string Foreground for gutter (signs, line numbers)
  -- Cursor and selection
  ---@field cur_line string Background for CursorLine
  ---@field cur_line_nr string Foreground for CursorLineNr
  ---@field lsp_ref string Background for LSP references
  ---@field visual string Background for Visual selection
  ---@field selection string Background for selections (e.g., Telescope)
  -- Semantic colors
  ---@field icon string Color for icons
  ---@field title string Color for titles
  -- Diagnostics
  ---@field error string Diagnostic error color
  ---@field warning string Diagnostic warning color
  ---@field info string Diagnostic info color
  ---@field hint string Diagnostic hint color
  ---@field ok string Diagnostic ok color
  ---@field todo string TODO comment color
  -- Tables
  ---@field diff table Diff colors (add, delete, change, text)
  ---@field special table Special syntax colors (comment, exception, keyword, param, property, whitespace)
  ---@field syntax table Syntax highlighting colors
  ---@field fs table Filesystem colors for file explorers
  ---@field cmp table Completion menu colors
  ---@field terminal TerminalColors Terminal palette
  ---@field mode ModeColors Mode colors for statusline/vim indicators
  local colors = palette

  util.bg = colors.bg
  util.fg = colors.fg

  -- Special value
  colors.none = "NONE"

  -- Diff colors (for inline diffs)
  colors.diff = {
    add = util.darken(colors.git.add, 0.60),
    delete = util.darken(colors.git.delete, 0.60),
    change = colors.gray6,
    text = colors.gray5,
  }

  -- UI backgrounds
  colors.black = util.blend_bg(colors.bg, 0.8, "#000000")
  colors.bg_menu = util.lighten(colors.bg, 0.95)
  colors.bg_popup = util.lighten(colors.bg, 0.955)
  colors.bg_statusline = util.lighten(colors.bg, 0.97)
  colors.border = colors.gray4
  colors.fg_sidebar = colors.gray6
  colors.fg_gutter = colors.gray4

  -- Cursor and selection
  colors.cur_line = util.lighten(colors.bg, 0.92)
  colors.cur_line_nr = colors.gray7
  colors.lsp_ref = util.lighten(colors.cur_line, 0.97)
  colors.visual = util.lighten(colors.cur_line, 0.95)
  colors.selection = colors.cur_line

  -- Special syntax overrides (can be partially defined in palette)
  colors.special = colors.special or {}
  colors.special = vim.tbl_deep_extend("keep", colors.special, {
    comment = util.lighten(colors.gray4, 0.85),
    exception = util.lighten(colors.gray5, 0.90),
    keyword = util.darken(colors.gray6, 0.90),
    param = util.lighten(colors.gray5, 0.70),
    property = util.darken(colors.gray7, 0.80),
    whitespace = util.lighten(colors.gray2, 0.85),
  })

  -- Semantic UI colors
  colors.icon = colors.gray6
  colors.title = colors.gray6

  -- Syntax highlighting
  colors.syntax = {
    boolean = colors.blue2,
    builtin = util.lighten(colors.gray5, 0.87),
    comment = colors.special.comment,
    const = colors.gray7,
    const_builtin = colors.gray6,
    func_call = colors.gray6,
    func_def = colors.gray8,
    func_param = colors.special.param,
    keyword = colors.special.keyword,
    keyword_exception = colors.special.exception,
    keyword_return = util.lighten(colors.gray5, 0.81),
    property = colors.special.property,
    punctuation = colors.gray8,
    special = colors.gray10,
    string = colors.gray7,
    string_escape = colors.lack,
    tag = colors.gray7,
    type = colors.gray7,
    type_def = colors.gray8,
    type_primitive = colors.gray7,
    var = colors.gray8,
    var_builtin = util.darken(colors.gray6, 0.90),
    var_member = colors.gray7,
  }

  -- Filesystem colors (for neo-tree, oil, etc.)
  colors.fs = {
    dir = colors.gray7,
    file = colors.gray8,
    exec = colors.blue2,
    link = colors.luster,
    binary_data = colors.gray6,
    socket = colors.gray6,
  }

  -- Completion menu colors
  colors.cmp = {
    kind = colors.gray7,
    snippet = colors.lack,
    deprecated = colors.gray4,
  }

  -- Diagnostics
  colors.error = colors.light_red
  colors.hint = colors.luster
  colors.info = colors.light_cyan
  colors.ok = colors.light_green
  colors.todo = colors.lack
  colors.warning = colors.light_yellow

  -- Mode colors (for statusline/vim mode indicators)
  ---@class ModeColors
  colors.mode = {
    normal = { bg = util.darken(colors.bg_statusline, 0.2), fg = colors.gray8 },
    insert = { bg = colors.glow, fg = colors.black },
    visual = { bg = colors.gray9, fg = colors.black },
    replace = { bg = colors.gray9, fg = colors.black }, -- same as visual
    command = { bg = colors.glow, fg = colors.black }, -- same as insert
  }

  -- Terminal colors
  -- Inspired by https://github.com/PieterHeijman/terminal-color-themes/blob/master/movies/Psycho.json
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
