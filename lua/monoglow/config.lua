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

---@class monoglow.Config
---@field on_colors? fun(colors: ColorScheme)
---@field on_highlights? fun(highlights: monoglow.Highlights, colors: ColorScheme)
M.defaults = {
  style = "z", -- The theme comes in three styles, `z`, a variant closer to lackluster `lack` and `void`
  glow = true, -- When `true`, some highlights will be bold (e.g. Function, Keyword, ...)
  transparent = false, -- When ``true`, the background will be transparent
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights monoglow.Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,

  plugins = {
    -- enable all plugins when not using lazy.nvim
    -- set to false to manually enable/disable plugins
    all = package.loaded.lazy == nil,
    -- uses your plugin manager to automatically enable needed plugins
    -- currently only lazy.nvim is supported
    auto = true,
    -- add any plugins here that you want to enable
    -- for all possible plugins, see:
    --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
    -- telescope = true,
  },
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
  eob = false, -- When `true`, the end-of-buffer line will be visible
}

---@type monoglow.Config
M.options = nil

---@param options? monoglow.Config
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

---@param opts? monoglow.Config
function M.extend(opts)
  return opts and vim.tbl_deep_extend("force", {}, M.options, opts) or M.options
end

setmetatable(M, {
  __index = function(_, k)
    if k == "options" then
      return M.defaults
    end
  end,
})

return M
