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
  return {
    ["@annotation"] = "PreProc",
    ["@attribute"] = { fg = c.syntax.keyword },
    ["@boolean"] = "Boolean",
    ["@character"] = "Character",
    ["@character.printf"] = "SpecialChar",
    ["@character.special"] = "SpecialChar",
    ["@comment"] = "Comment",
    ["@comment.documentation"] = "Comment",
    ["@comment.error"] = { fg = c.error },
    ["@comment.hint"] = { fg = c.hint },
    ["@comment.info"] = { fg = c.info },
    ["@comment.note"] = { fg = c.hint },
    ["@comment.todo"] = { fg = c.todo },
    ["@comment.warning"] = { fg = c.warning },
    ["@constant"] = "Constant",
    ["@constant.builtin"] = { fg = c.syntax.const_builtin },
    ["@constant.macro"] = "Define",
    ["@constructor"] = "Delimiter", -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
    ["@diff.delta"] = "DiffChange",
    ["@diff.minus"] = "DiffDelete",
    ["@diff.plus"] = "DiffAdd",
    ["@function"] = { fg = c.syntax.func_def },
    ["@function.builtin"] = { fg = c.syntax.builtin },
    ["@function.call"] = { fg = c.syntax.func_call },
    ["@function.macro"] = "Macro",
    ["@function.method"] = "@function",
    ["@function.method.call"] = "@function.call",
    ["@keyword"] = { fg = c.syntax.keyword }, -- For keywords that don't fall in previous categories.
    ["@keyword.conditional"] = "Conditional",
    ["@keyword.coroutine"] = "@keyword",
    ["@keyword.debug"] = "Debug",
    ["@keyword.directive"] = "PreProc",
    ["@keyword.directive.define"] = "Define",
    ["@keyword.exception"] = { fg = c.syntax.keyword_exception },
    ["@keyword.import"] = "Include",
    ["@keyword.operator"] = "@operator",
    ["@keyword.repeat"] = "Repeat",
    ["@keyword.return"] = { fg = c.syntax.keyword_return },
    ["@keyword.storage"] = "StorageClass",
    ["@label"] = { fg = c.title }, -- For labels: `label:` in C and `:label:` in Lua.
    ["@markup"] = "@none",
    ["@markup.emphasis"] = { italic = true },
    ["@markup.environment"] = "Macro",
    ["@markup.environment.name"] = "Type",
    ["@markup.heading"] = "Title",
    ["@markup.italic"] = { italic = true },
    ["@markup.link"] = { fg = c.gray6 },
    ["@markup.link.label"] = "SpecialChar",
    ["@markup.link.label.symbol"] = "Identifier",
    ["@markup.link.url"] = "Underlined",
    ["@markup.list"] = { fg = c.gray4 }, -- For special punctutation that does not fall in the categories before.
    ["@markup.list.checked"] = { fg = c.light_green }, -- For brackets and parens.
    ["@markup.list.unchecked"] = { fg = c.light_cyan }, -- For brackets and parens.
    ["@markup.math"] = "Special",
    ["@markup.quote"] = { fg = c.gray6 },
    ["@markup.raw"] = "String",
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.strong"] = { fg = c.gray4, bold = true },
    ["@markup.underline"] = { underline = true },
    ["@module"] = "Include",
    ["@module.builtin"] = { fg = c.syntax.builtin }, -- Variable names that are defined by the languages, like `this` or `self`.
    ["@namespace.builtin"] = "@variable.builtin",
    ["@none"] = {},
    ["@number"] = "Number",
    ["@number.float"] = "Float",
    ["@operator"] = "Operator", -- For any operator: `+`, but also `->` and `*` in C.
    ["@property"] = { fg = c.syntax.property },
    ["@punctuation.bracket"] = "Delimiter", -- For brackets and parens.
    ["@punctuation.delimiter"] = "Delimiter", -- For delimiters ie: `.`
    ["@punctuation.special"] = "Delimiter", -- For special symbols (e.g. `{}` in string interpolation)
    ["@string"] = "String",
    ["@string.escape"] = { fg = c.syntax.string_escape }, -- For escape characters within a string.
    ["@string.regexp"] = { fg = c.syntax.string_escape }, -- For regexes.
    ["@string.special"] = { fg = c.syntax.string_escape },
    ["@tag"] = { fg = c.syntax.tag },
    ["@tag.attribute"] = { fg = c.gray4 },
    ["@tag.delimiter"] = "@tag",
    ["@type"] = "Type",
    ["@type.builtin"] = { fg = c.syntax.type_primitive },
    ["@type.definition"] = { fg = c.syntax.type_def },
    ["@type.qualifier"] = "@keyword",
    ["@variable"] = { fg = c.syntax.var }, -- Any variable name that does not have another highlight.
    ["@variable.builtin"] = { fg = c.syntax.builtin }, -- Variable names that are defined by the languages, like `this` or `self`.
    ["@variable.member"] = { fg = c.syntax.var_member }, -- For fields.
    ["@variable.parameter"] = { fg = c.syntax.func_param },
    ["@variable.parameter.builtin"] = "@variable.builtin", -- For builtin parameters of a function, e.g. "..." or Smali's p[1-99]
  }
end

return M
