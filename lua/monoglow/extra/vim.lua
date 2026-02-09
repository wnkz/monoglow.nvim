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

local mapping = {
  fg = "guifg",
  bg = "guibg",
  sp = "guisp",
}

local excluded_plugins = {
  "blink.cmp",
}

--- @param colors ColorScheme
--- @param groups monoglow.Highlights
--- @param opts monoglow.Config
function M.generate(colors, groups, opts)
  util.bg = colors.bg
  opts.plugins = { all = false, auto = false, treesitter = false }
  local Groups = require("monoglow.groups")
  for p, n in pairs(Groups.plugins) do
    if not p:find("nvim") and not vim.tbl_contains(excluded_plugins, p) then
      opts.plugins[n] = true
    end
  end
  groups = Groups.setup(colors, opts)
  local lines = {
    ([[
let g:colors_name = "monoglow-%s"
hi clear
  ]]):format(colors._style),
  }

  groups = vim.deepcopy(groups)
  for name in pairs(groups) do
    if name:sub(1, 1) == "@" then
      groups[name] = nil
    end
  end
  local names = vim.tbl_keys(groups)
  table.sort(names)

  local used = {}
  for _, name in ipairs(names) do
    local hl = groups[name]
    if type(hl) == "string" then
      hl = { link = hl }
    end

    if not hl.link then
      local props = {}

      -- fg/bg/sp
      for k, v in pairs(hl) do
        if mapping[k] then
          props[#props + 1] = ("%s=%s"):format(mapping[k], v)
        end
      end

      -- gui
      local gui = {}
      for _, attr in ipairs({
        "bold",
        "underline",
        "undercurl",
        "italic",
        "strikethrough",
        "underdouble",
        "underdotted",
        "underdashed",
        "inverse",
        "standout",
        "nocombine",
        "altfont",
      }) do
        if hl[attr] then
          gui[#gui + 1] = attr
        end
      end
      if #gui > 0 then
        props[#props + 1] = ("gui=%s"):format(table.concat(gui, ","))
      end

      if #props > 0 then
        if not hl.bg then
          props[#props + 1] = "guibg=NONE"
        end
        table.sort(props)
        used[name] = true
        lines[#lines + 1] = ("hi %s %s"):format(name, table.concat(props, " "))
      else
        print("monoglow: invalid highlight group: " .. name)
      end
    end
  end

  for _, name in ipairs(names) do
    local hl = groups[name]
    if type(hl) == "string" then
      hl = { link = hl }
    end

    if hl.link then
      if hl.link:sub(1, 1) ~= "@" and groups[hl.link] and used[hl.link] then
        lines[#lines + 1] = ("hi! link %s %s"):format(name, hl.link)
      end
    end
  end

  return table.concat(lines, "\n")
end

return M
