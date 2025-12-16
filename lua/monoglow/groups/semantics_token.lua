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
  -- NOTE: Many LSP semantic token groups are NOT defined here because Neovim
  -- provides sensible defaults in highlight_group.c that link to TS groups:
  --   @lsp.type.comment → @comment, @lsp.type.decorator → @attribute,
  --   @lsp.type.enum → @type, @lsp.type.enumMember → @constant,
  --   @lsp.type.keyword → @keyword, @lsp.type.namespace → @module,
  --   @lsp.type.number → @number, @lsp.type.operator → @operator,
  --   @lsp.type.parameter → @variable.parameter, @lsp.type.property → @property,
  --   @lsp.type.string → @string, @lsp.type.variable → {} (defers to TS)
  return {
    -- custom types (no Neovim defaults)
    ["@lsp.type.boolean"] = "@boolean",
    ["@lsp.type.builtinType"] = "@type.builtin",
    ["@lsp.type.deriveHelper"] = "@attribute",
    ["@lsp.type.escapeSequence"] = "@string.escape",
    ["@lsp.type.formatSpecifier"] = "@markup.list",
    ["@lsp.type.generic"] = "@variable",
    ["@lsp.type.lifetime"] = "@keyword.storage",
    ["@lsp.type.selfKeyword"] = "@variable.builtin",
    ["@lsp.type.selfTypeKeyword"] = "@variable.builtin",
    ["@lsp.type.typeAlias"] = "@type.definition",
    ["@lsp.type.unresolvedReference"] = { undercurl = true, sp = c.error },

    -- language-specific overrides
    ["@lsp.type.namespace.python"] = "@variable",

    -- type modifiers (defaultLibrary, async, injected, etc.)
    ["@lsp.typemod.class.defaultLibrary"] = "@type.builtin",
    ["@lsp.typemod.enum.defaultLibrary"] = "@type.builtin",
    ["@lsp.typemod.enumMember.defaultLibrary"] = "@constant.builtin",
    ["@lsp.typemod.function.defaultLibrary"] = "@function.builtin",
    ["@lsp.typemod.keyword.async"] = "@keyword.coroutine",
    ["@lsp.typemod.keyword.injected"] = "@keyword",
    ["@lsp.typemod.macro.defaultLibrary"] = "@function.builtin",
    ["@lsp.typemod.method.defaultLibrary"] = "@function.builtin",
    ["@lsp.typemod.operator.injected"] = "@operator",
    ["@lsp.typemod.string.injected"] = "@string",
    ["@lsp.typemod.struct.defaultLibrary"] = "@type.builtin",
    ["@lsp.typemod.variable.callable"] = "@function",
    ["@lsp.typemod.variable.defaultLibrary"] = "@variable.builtin",
    ["@lsp.typemod.variable.injected"] = "@variable",
    ["@lsp.typemod.variable.static"] = "@constant",
  }
end

return M
