-- monoglow.nvim
-- Portions of this file include code derived from "tokyonight.nvim" (https://github.com/folke/tokyonight.nvim),
-- which is licensed under the Apache License, Version 2.0. See the NOTICE file for more details.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0

local M = {}

---@type monoglow.HighlightsFn
function M.get(c)
  -- NOTE: Many TS groups are NOT defined here because Neovim provides sensible
  -- defaults in highlight_group.c that link to standard Vim groups:
  --   @boolean → Boolean, @character → Character, @comment → Comment,
  --   @constant → Constant, @diff.plus → Added, @diff.minus → Removed,
  --   @diff.delta → Changed, @markup.heading → Title, @number → Number,
  --   @number.float → Float, @operator → Operator, @string → String, @type → Type
  return {
    ["@annotation"] = "PreProc", -- Annotations (e.g., @decorator in Python)
    ["@attribute"] = { fg = c.syntax.keyword }, -- Attributes (e.g., HTML tag attributes)
    ["@character.printf"] = "SpecialChar", -- printf format specifiers
    ["@comment.documentation"] = "Comment", -- documentation comments
    ["@comment.error"] = { fg = c.error }, -- ERROR, BUG
    ["@comment.hint"] = { fg = c.hint }, -- HINT
    ["@comment.info"] = { fg = c.info }, -- INFO
    ["@comment.note"] = { fg = c.hint }, -- NOTE, XXX
    ["@comment.todo"] = { fg = c.todo }, -- TODO, FIXME
    ["@comment.warning"] = { fg = c.warning }, -- WARNING, WARN, HACK
    ["@constant.builtin"] = { fg = c.syntax.const_builtin }, -- Built-in constants (e.g., nil, true, false)
    ["@constant.macro"] = "Define", -- Constants defined by macros
    ["@constructor"] = "Delimiter", -- Constructor calls: `{ }` in Lua, `new Class()` in Java
    ["@function"] = { fg = c.syntax.func_def }, -- Function definitions
    ["@function.builtin"] = { fg = c.syntax.builtin }, -- Built-in functions
    ["@function.call"] = { fg = c.syntax.func_call }, -- Function calls
    ["@function.macro"] = "Macro", -- Macro functions
    ["@function.method"] = "@function", -- Method definitions
    ["@function.method.call"] = "@function.call", -- Method calls
    ["@keyword"] = { fg = c.syntax.keyword }, -- Keywords that don't fall in other categories
    ["@keyword.conditional"] = "Conditional", -- if, else, elseif, then, etc.
    ["@keyword.coroutine"] = "@keyword", -- Coroutine keywords (e.g., await, async)
    ["@keyword.debug"] = "Debug", -- Debugging keywords
    ["@keyword.directive"] = "PreProc", -- Preprocessor directives
    ["@keyword.directive.define"] = "Define", -- Preprocessor define directives
    ["@keyword.exception"] = { fg = c.syntax.keyword_exception, bold = true }, -- try, catch, throw, raise
    ["@keyword.import"] = "Include", -- import, include, require
    ["@keyword.operator"] = "@operator", -- Keyword operators (e.g., and, or, not)
    ["@keyword.repeat"] = "Repeat", -- for, while, loop
    ["@keyword.return"] = { fg = c.syntax.keyword_return, bold = true }, -- return, yield
    ["@keyword.storage"] = "StorageClass", -- static, const, mut
    ["@label"] = { fg = c.title }, -- labels: `label:` in C, `::label::` in Lua
    ["@markup"] = "@none", -- Generic markup (fallback, not used directly)
    ["@markup.emphasis"] = { italic = true }, -- Emphasized text (e.g., *text*)
    ["@markup.environment"] = "Macro", -- Environments in markup (e.g., LaTeX environments)
    ["@markup.environment.name"] = "Type", -- Environment names
    ["@markup.italic"] = { italic = true }, -- Italic text
    ["@markup.link"] = { fg = c.gray6 }, -- Links in markup
    ["@markup.link.label"] = "SpecialChar", -- Link labels (e.g., [text] in [text](url))
    ["@markup.link.label.symbol"] = "Identifier", -- Link label symbols
    ["@markup.link.url"] = "Underlined", -- URLs
    ["@markup.list"] = { fg = c.gray4 }, -- List markers (-, *, 1.)
    ["@markup.list.checked"] = { fg = c.light_green }, -- Checked checkbox: [x]
    ["@markup.list.unchecked"] = { fg = c.light_cyan }, -- Unchecked checkbox: [ ]
    ["@markup.math"] = "Special", -- Math environments (e.g., LaTeX $...$)
    ["@markup.quote"] = { fg = c.gray6 }, -- Block quotes
    ["@markup.raw"] = "String", -- Raw/verbatim text (e.g., `code`)
    ["@markup.strikethrough"] = { strikethrough = true }, -- Strikethrough text
    ["@markup.strong"] = { fg = c.gray4, bold = true }, -- Bold text (e.g., **text**)
    ["@markup.underline"] = { underline = true }, -- Underlined text
    ["@module"] = "Include", -- Modules and namespaces
    ["@module.builtin"] = { fg = c.syntax.builtin }, -- Built-in modules
    ["@namespace.builtin"] = "@variable.builtin", -- Built-in namespaces (deprecated, use @module.builtin)
    ["@none"] = {}, -- No highlighting
    ["@property"] = { fg = c.syntax.property }, -- Object/struct properties
    ["@punctuation.bracket"] = "Delimiter", -- Brackets: (), [], {}
    ["@punctuation.delimiter"] = "Delimiter", -- Delimiters: ., ,, ;
    ["@punctuation.special"] = "Delimiter", -- Special punctuation (e.g., #{} in string interpolation)
    ["@string.escape"] = { fg = c.syntax.string_escape }, -- Escape sequences: \n, \t
    ["@string.regexp"] = { fg = c.syntax.string_escape }, -- Regular expressions
    ["@string.special"] = { fg = c.syntax.string_escape }, -- Special strings (e.g., URLs, file paths)
    ["@tag"] = { fg = c.syntax.tag }, -- XML/HTML tags
    ["@tag.attribute"] = { fg = c.gray6 }, -- Tag attributes
    ["@tag.builtin"] = "@tag", -- Built-in tags (e.g., HTML5 semantic tags)
    ["@tag.delimiter"] = "@tag", -- Tag delimiters: <, >, />
    ["@type.builtin"] = { fg = c.syntax.type_primitive }, -- Built-in types (e.g., int, string)
    ["@type.definition"] = { fg = c.syntax.type_def }, -- Type definitions
    ["@type.qualifier"] = "@keyword", -- Type qualifiers (e.g., const, volatile)
    ["@variable"] = { fg = c.syntax.var }, -- Variable names
    ["@variable.builtin"] = { fg = c.syntax.var_builtin }, -- Built-in variables (e.g., this, self)
    ["@variable.member"] = { fg = c.syntax.var_member }, -- Object/struct member variables
    ["@variable.parameter"] = { fg = c.syntax.func_param }, -- Function parameters
    ["@variable.parameter.builtin"] = "@variable.builtin", -- Built-in parameters (e.g., ... in Lua)
  }
end

return M
