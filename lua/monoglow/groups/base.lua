local util = require("monoglow.util")

local M = {}

function M.get(c, opts)
  return {
    -- editor:text
    Normal = { fg = c.fg, bg = opts.transparent and c.none or c.bg }, -- normal text
    NormalNC = "Normal", -- normal text in non-current windows
    Title = { fg = c.title },
    Whitespace = { fg = c.whitespace },
    EndOfBuffer = { fg = opts.eob and c.gray2 or c.bg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.

    -- editor:visual
    Visual = { bg = c.visual },
    VisualNOS = "Visual",
    LspReferenceText = { bg = c.gray4 },

    -- editor:float
    NormalFloat = { fg = c.fg, bg = c.bg_popup },
    FloatBorder = { fg = c.border, bg = c.bg_popup },
    FloatTitle = { fg = c.title },

    -- editor:nontext
    NonText = { fg = c.gray4 },

    -- editor:cursor
    Cursor = { fg = c.bg, bg = c.fg },
    CursorLine = { bg = c.selection },
    CursorLineNr = { fg = c.cur_line_nr },
    LineNr = { fg = c.line_nr },
    SignColumn = { bg = opts.transparent and c.none or c.bg },

    -- editor:search
    CurSearch = "IncSearch",
    IncSearch = { fg = c.black, bg = c.glow }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Search = { fg = c.glow, bold = true },
    Substitute = "Search",

    -- editor:diff
    DiffAdd = { fg = c.bg, bg = c.diff.add }, -- diff mode: Added line |diff.txt|
    DiffChange = { fg = c.bg, bg = c.diff.change }, -- diff mode: Changed line |diff.txt|
    DiffDelete = { fg = c.bg, bg = c.diff.delete }, -- diff mode: Deleted line |diff.txt|
    DiffText = { fg = c.bg, bg = c.blue2 },

    -- editor:menu
    Pmenu = { fg = c.fg, bg = opts.transparent and c.none or c.bg_menu },
    PmenuSel = { fg = c.black, bg = c.glow, bold = true },
    PmenuSbar = { fg = c.gray5, bg = c.gray3 },
    PmenuThumb = { fg = c.gray3, bg = c.gray5 },

    -- editor:statusline
    StatusLine = { fg = c.gray7, bg = c.statusline }, -- status line of current window
    StatusLineNC = { fg = c.gray4, bg = c.gray1 }, -- status lines of not-current windows

    -- editor:misc
    Directory = { fg = c.fs.dir },

    -- syntax
    Conditional = "Keyword",
    Exception = "Keyword",
    Function = { fg = c.syntax.func_call, bold = opts.glow }, -- function name (also: methods for classes)
    Identifier = { fg = c.syntax.type, bold = opts.glow }, -- (preferred) any variable name
    Keyword = { fg = c.syntax.keyword, bold = opts.glow }, --  any other keyword
    Label = "Keyword",
    PreProc = "Keyword", -- (preferred) generic Preprocessor
    Repeat = "Keyword",
    Special = { fg = c.syntax.special }, -- (preferred) any special symbol
    Statement = "Keyword", -- (preferred) any statement
    Type = { fg = c.syntax.type }, -- (preferred) int, long, char, etc.
    Variable = { fg = c.syntax.var },

    -- syntax:constants
    Boolean = { fg = c.syntax.boolean },
    Character = "String",
    Constant = { fg = c.syntax.const }, -- (preferred) any constant
    Float = "Constant",
    Number = "Constant",
    String = { fg = c.syntax.string }, -- a string constant: "this is a string"

    -- syntax:punctuation
    Quote = "String",
    Operator = { fg = c.glow, bold = opts.glow },
    Delimiter = { fg = c.syntax.punctuation }, -- character that needs attention

    -- syntax:comments
    Comment = { fg = c.syntax.comment, italic = true }, -- any comment

    -- diagnostics
    DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticUnnecessary = { fg = c.fg }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticVirtualTextError = { bg = util.blend_bg(c.error, 0.1), fg = c.error }, -- Used for "Error" diagnostic virtual text
    DiagnosticVirtualTextWarn = { bg = util.blend_bg(c.warning, 0.1), fg = c.warning }, -- Used for "Warning" diagnostic virtual text
    DiagnosticVirtualTextInfo = { bg = util.blend_bg(c.info, 0.1), fg = c.info }, -- Used for "Information" diagnostic virtual text
    DiagnosticVirtualTextHint = { bg = util.blend_bg(c.hint, 0.1), fg = c.hint }, -- Used for "Hint" diagnostic virtual text
    DiagnosticUnderlineError = { undercurl = true, sp = c.error }, -- Used to underline "Error" diagnostics
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning }, -- Used to underline "Warning" diagnostics
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.info }, -- Used to underline "Information" diagnostics
    DiagnosticUnderlineHint = { undercurl = true, sp = c.hint }, -- Used to underline "Hint" diagnostics
  }
end

return M
