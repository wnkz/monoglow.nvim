local util = require("monoglow.util")

local M = {}

function M.get(c, opts)
  return {
    -- editor
    EndOfBuffer = { fg = opts.eob and c.gray9 or c.bg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    Visual = { bg = c.gray10 },

    -- editor:text
    Normal = { fg = c.fg, bg = opts.transparent and c.none or c.bg }, -- normal text
    NormalNC = "Normal", -- normal text in non-current windows
    NormalFloat = { fg = c.fg, bg = c.gray11 },

    -- editor:cursor
    Cursor = { fg = c.bg, bg = c.fg },
    LineNr = { fg = c.gray8 },

    -- editor:search
    CurSearch = "IncSearch",
    IncSearch = { fg = c.bg, bg = c.glow }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Search = { fg = c.glow, bold = true },
    Substitute = "Search",

    -- editor:diff
    DiffAdd = { fg = c.bg, bg = c.diff.add }, -- diff mode: Added line |diff.txt|
    DiffChange = { fg = c.bg, bg = c.diff.change }, -- diff mode: Changed line |diff.txt|
    DiffDelete = { fg = c.bg, bg = c.diff.delete }, -- diff mode: Deleted line |diff.txt|
    DiffText = { fg = c.bg, bg = c.blue2 },

    -- editor:menu
    Pmenu = { fg = c.fg, bg = opts.transparent and c.none or c.bg },
    PmenuSel = { fg = c.bg, bg = c.glow, bold = true },

    -- editor:statusline
    StatusLine = { fg = c.fg, bg = c.gray12 }, -- status line of current window
    StatusLineNC = { fg = c.gray5, bg = c.gray11 }, -- status lines of not-current windows

    -- syntax
    Delimiter = { fg = c.gray2 }, --  character that needs attention
    Function = { fg = c.gray3, bold = opts.glow }, -- function name (also: methods for classes)
    Identifier = { fg = c.gray5, bold = opts.glow }, -- (preferred) any variable name
    Keyword = { fg = c.gray1, bold = opts.glow }, --  any other keyword
    Operator = { fg = c.glow, bold = opts.glow },
    PreProc = "Keyword", -- (preferred) generic Preprocessor
    Special = { fg = c.gray2 }, -- (preferred) any special symbol
    Type = { fg = c.gray6 }, -- (preferred) int, long, char, etc.

    -- syntax:constants
    Boolean = { fg = c.blue2 },
    Character = "String",
    Constant = { fg = c.blue1 }, -- (preferred) any constant
    Float = "Constant",
    Number = "Constant",
    String = { fg = c.gray5 }, --   a string constant: "this is a string"

    -- syntax:comments
    Comment = { fg = c.gray7, italic = true }, -- any comment

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
