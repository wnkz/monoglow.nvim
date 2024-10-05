local util = require("monoglow.util")

local M = {}

M.plugins = {
  ["dashboard-nvim"] = "dashboard",
  ["telescope.nvim"] = "telescope",
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
    treesitter = true,
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
