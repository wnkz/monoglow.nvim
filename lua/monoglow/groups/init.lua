-- monoglow.nvim
-- Portions of this file include code derived from "tokyonight.nvim" (https://github.com/folke/tokyonight.nvim),
-- which is licensed under the Apache License, Version 2.0. See the NOTICE file for more details.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0

local util = require("monoglow.util")

local M = {}

M.plugins = {
  ["dashboard-nvim"] = "dashboard",
  ["flash.nvim"] = "flash",
  ["gitsigns.nvim"] = "gitsigns",
  ["markview.nvim"] = "markview",
  ["mason.nvim"] = "mason",
  ["neo-tree.nvim"] = "neo-tree",
  ["nvim-cmp"] = "cmp",
  ["oil.nvim"] = "oil",
  ["telescope.nvim"] = "telescope",
  ["which-key.nvim"] = "which-key",
  ["window-picker"] = "nvim-window-picker",
}

local me = debug.getinfo(1, "S").source:sub(2)
me = vim.fn.fnamemodify(me, ":h")

function M.get_group(name)
  return util.mod("monoglow.groups." .. name)
end

function M.get(name, colors, opts)
  local mod = M.get_group(name)
  return mod.get(colors, opts)
end

function M.setup(colors, opts)
  local groups = {
    base = true,
    kinds = true,
    treesitter = true,
    semantics_token = true,
  }

  if opts.plugins.all then
    for _, group in pairs(M.plugins) do
      groups[group] = true
    end
  elseif opts.plugins.auto and package.loaded.lazy then
    local plugins = require("lazy.core.config").plugins
    for plugin, group in pairs(M.plugins) do
      if plugins[plugin] then
        groups[group] = true
      end
    end
  end

  -- manually enable/disable plugins
  for plugin, group in pairs(M.plugins) do
    local use = opts.plugins[group]
    use = use == nil and opts.plugins[plugin] or use
    if use ~= nil then
      if type(use) == "table" then
        use = use.enabled
      end
      groups[group] = use or nil
    end
  end

  local names = vim.tbl_keys(groups)
  table.sort(names)

  local ret = {}
  -- merge highlights
  for group in pairs(groups) do
    for k, v in pairs(M.get(group, colors, opts)) do
      ret[k] = v
    end
  end

  return ret, groups
end

return M
