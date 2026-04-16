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

--- @param colors ColorScheme
function M.generate(colors)
  -- Ref: https://github.com/helix-editor/helix/blob/master/book/src/themes.md
  -- nil is used when no equivalent was found.
  --
  -- Helix reserves 17 default palette names (default, black, red, green, yellow,
  -- blue, magenta, cyan, gray, light-{red,green,yellow,blue,magenta,cyan,gray},
  -- white). Custom palette entries override them. Our `light_*` keys use
  -- underscores, so they do NOT shadow Helix's hyphenated defaults; `"helix"`
  -- overrides below must only reference palette keys that actually exist in
  -- `lua/monoglow/colors/init.lua` after `M.flatten(colors)`.
  local mapping = M.flatten({
    attribute = "@attribute",
    type = {
      "Type",
      builtin = "@type.builtin",
      parameter = "@lsp.type.typeParameter",
      enum = {
        "@lsp.type.enum",
        variant = "@lsp.type.enumMember",
      },
    },
    -- rust: pattern matching `let Some(_) = ...`
    --                             ^^^^
    constructor = "Type",
    constant = {
      "Constant",
      builtin = {
        "@constant.builtin",
        boolean = "Boolean",
      },
      character = {
        "Character",
        escape = "@string.escape",
      },
      numeric = {
        "Number",
        float = "Float",
        integer = "Number",
      },
    },
    string = {
      "String",
      regexp = "@string.regexp",
      special = {
        "@string.special",
        path = nil,
        url = nil,
        symbol = nil,
      },
    },
    comment = {
      "@comment",
      line = {
        nil,
        documentation = "@comment.documentation",
      },
      block = {
        nil,
        documentation = "@comment.documentation",
      },
      unused = { "helix", fg = "syntax.comment", modifiers = { "italic" } },
    },
    variable = {
      "@variable",
      builtin = "@variable.builtin",
      parameter = "@variable.parameter",
      other = {
        nil,
        member = "@variable.member",
      },
    },
    label = "@label",
    punctuation = {
      "Delimiter",
      delimiter = "@punctuation.delimiter",
      bracket = "@punctuation.bracket",
      special = "@punctuation.special",
    },
    keyword = {
      "@keyword",
      control = {
        "Statement",
        conditional = "Conditional",
        ["repeat"] = "Repeat",
        import = "Include",
        ["return"] = "@keyword.return",
        exception = "Exception",
      },
      operator = "Statement",
      directive = "PreProc",
      ["function"] = { "helix", fg = "fg", modifiers = { "bold" } },
      storage = {
        "StorageClass",
        type = "Structure",
        modifier = "StorageClass",
      },
    },
    operator = "Operator",
    ["function"] = {
      "Function",
      builtin = "@function.builtin",
      method = "@function.method",
      macro = "@function.macro",
      -- Defined as "preprocessor in C", so using "PreProc", not sure though
      special = "PreProc",
    },
    tag = {
      "@tag",
      builtin = "@tag.builtin",
    },
    namespace = "@lsp.type.namespace",
    special = "Special",
    markup = {
      nil,
      heading = {
        { "helix", fg = "fg_sidebar", modifiers = { "bold" } },
        marker = nil,
        -- post-processed to remove the 'h' as we already use the first element (1) as the root value.
        h1 = nil,
        h2 = nil,
        h3 = nil,
        h4 = nil,
        h5 = nil,
        h6 = nil,
        -- UI --
        completion = { "helix", fg = "fg", bg = "bg_menu", modifiers = { "bold" } },
        hover = { "helix", fg = "black", bg = "glow", modifiers = { "bold" } },
      },
      list = {
        "@markup.list",
        unnumbered = nil,
        numbered = nil,
        checked = "@markup.list.checked",
        unchecked = "@markup.list.unchecked",
      },
      bold = { "helix", fg = "fg", modifiers = { "bold" } },
      italic = { "helix", fg = "gray6", modifiers = { "italic" } },
      strikethrough = { "helix", fg = "gray7", modifiers = { "crossed_out" } },
      link = {
        { "helix", fg = "fg_sidebar", modifiers = { "underline" } },
        url = { "helix", fg = "glow", underline = { style = "line" } },
        label = { "helix", fg = "gray10", modifiers = { "underline" } },
        text = "@markup.link",
      },
      quote = "@markup.quote",
      raw = {
        "@markup.raw",
        inline = "@markup.raw",
        block = nil,
        -- UI --
        completion = nil,
        hover = nil,
      },
      -- UI --
      normal = {
        nil,
        completion = "Pmenu",
        hover = { "helix", fg = "syntax.keyword_return", bg = "bg_menu" },
      },
    },
    diff = {
      nil,
      plus = {
        { "helix", fg = "diff.add" },
        gutter = "Added",
      },
      minus = {
        { "helix", fg = "diff.delete" },
        gutter = "Removed",
      },
      delta = {
        { "helix", fg = "diff.change" },
        moved = { "helix", fg = "diff.change" },
        conflict = { "helix", fg = "diff.text" },
        gutter = "Changed",
      },
    },
    ui = {
      background = {
        { "helix", bg = "bg" },
        separator = nil,
      },
      bufferline = {
        { "helix", fg = "fg_sidebar", bg = "bg_statusline" },
        active = { "helix", fg = "fg", bg = "bg", modifiers = { "bold" } },
        background = { "helix", bg = "bg_statusline" },
      },
      cursor = {
        "Cursor",
        normal = nil,
        insert = nil,
        select = nil,
        match = "MatchParen",
        primary = {
          nil,
          normal = nil,
          insert = nil,
          select = nil,
        },
      },
      debug = {
        breakpoint = nil,
        active = nil,
      },
      gutter = {
        nil,
        selected = nil,
      },
      highlight = {
        nil,
        frameline = nil,
      },
      linenr = {
        "LineNr",
        selected = "CursorLineNr",
      },
      picker = {
        nil,
        header = {
          "TelescopePromptTitle",
          column = {
            nil,
            active = "TelescopeSelection",
          },
        },
      },
      statusline = {
        "StatusLine",
        inactive = "StatusLineNc",
        -- Mode pills (inspired by lualine).
        normal = { "helix", fg = "black", bg = "glow", modifiers = { "bold" } },
        insert = { "helix", fg = "black", bg = "light_cyan", modifiers = { "bold" } },
        select = { "helix", fg = "black", bg = "light_yellow", modifiers = { "bold" } },
        separator = { "helix", fg = "border" },
      },
      popup = {
        "TelescopeBorder",
        info = nil,
      },
      window = "WinSeparator",
      help = nil,
      text = {
        "Normal",
        -- TelescopeSelection
        focus = "Visual",
        inactive = "Comment",
        info = "TelescopeNormal",
        directory = "Directory",
        symlink = { "helix", fg = "fs.link" },
      },
      virtual = {
        ruler = nil,
        whitespace = "Whitespace",
        ["indent-guide"] = nil,
        ["inlay-hint"] = {
          "DiagnosticVirtualTextHint",
          parameter = nil,
          type = nil,
        },
        wrap = nil,
        ["jump-label"] = { "helix", fg = "glow", modifiers = { "bold" } },
      },
      menu = {
        "Pmenu",
        selected = "PmenuSel",
        scroll = {
          "helix",
          fg = M.to_rgb(vim.api.nvim_get_hl(0, { name = "PmenuThumb" }).bg),
          bg = M.to_rgb(vim.api.nvim_get_hl(0, { name = "PmenuSbar" }).bg),
        },
      },
      selection = {
        { "helix", bg = "visual" },
        primary = nil,
      },
      cursorline = {
        primary = nil,
        secondary = nil,
      },
      cursorcolumn = {
        primary = nil,
        secondary = nil,
      },
    },
    hint = "DiagnosticHint",
    info = "DiagnosticInfo",
    warning = "DiagnosticWarn",
    error = "DiagnosticError",
    diagnostic = {
      nil,
      hint = { "helix", fg = "hint", underline = { style = "curl" } },
      info = { "helix", fg = "info", underline = { style = "curl" } },
      warning = { "helix", fg = "warning", underline = { style = "curl" } },
      error = { "helix", fg = "error", underline = { style = "curl" } },
      unnecessary = { "helix", fg = "gray5", modifiers = { "italic" } },
    },
  })

  local config = {}
  for hx_scope, group in M.pairsByKeys(mapping) do
    -- print(hx_scope, util.dump(group))
    hx_scope = hx_scope:gsub("%.h(%d)", ".%1")
    if hx_scope:match("%.") then
      hx_scope = "\"" .. hx_scope .. "\""
    end

    if group == nil then
      goto continue
    end

    if type(group) == "table" and group[1] == "helix" then
      table.remove(group, 1)
      table.insert(config, string.format("%s = %s", hx_scope, M.to_toml(group)))
      goto continue
    end

    local highlight = vim.api.nvim_get_hl(0, { name = group })
    while highlight and highlight.link do
      highlight = vim.api.nvim_get_hl(0, { name = highlight.link })
    end
    if highlight == nil then
      print("Unknown highlight for " .. hx_scope)
      goto continue
    end
    local config_str = M.to_helix_config(highlight)
    if config_str == nil then
      goto continue
    end
    table.insert(config, string.format("%s = %s", hx_scope, config_str))

    ::continue::
  end

  table.insert(config, "\n[palette]")
  for name, color in M.pairsByKeys(M.flatten(colors)) do
    if name:match("%.") then
      name = "\"" .. name .. "\""
    end
    if type(color) == "string" and not string.starts(name, "_") and name ~= "none" then
      table.insert(config, string.format("%s = \"%s\"", name, color))
    end
  end
  return table.concat(config, "\n")
end

function string.starts(String, Start)
  return string.sub(String, 1, string.len(Start)) == Start
end

function M.flatten(t)
  local res = {}
  for k, v in pairs(t) do
    if type(v) == "table" then
      if v[1] ~= "helix" then
        for k2, v2 in pairs(M.flatten(v)) do
          -- Special case for tables like:
          -- { type = { "@type", enum = "@type.enum" } }
          if k2 == 1 then
            res[k] = v2
          else
            res[k .. "." .. k2] = v2
          end
        end
      else
        res[k] = v
      end
    else
      res[k] = v
    end
  end
  return res
end

-- https://www.lua.org/pil/19.3.html
function M.pairsByKeys(t, f)
  local a = {}
  for n in pairs(t) do
    table.insert(a, n)
  end
  table.sort(a, f)
  local i = 0 -- iterator variable
  local iter = function() -- iterator function
    i = i + 1
    if a[i] == nil then
      return nil
    else
      return a[i], t[a[i]]
    end
  end
  return iter
end

function M.to_helix_config(highlight)
  local style = {}
  for hx_name, nvim_name in pairs({ fg = "fg", bg = "bg" }) do
    style[hx_name] = M.to_rgb(highlight[nvim_name])
  end
  local modifiers = {}
  for _, mods in ipairs({ highlight, highlight.cterm }) do
    if mods then
      if mods.bold then
        modifiers.bold = true
      end
      if mods.italic then
        modifiers.italic = true
      end
      if mods.underline then
        style.underline = {
          style = "line",
        }
      end
      if mods.undercurl and highlight.sp then
        style.underline = {
          color = M.to_rgb(highlight.sp),
          style = "curl",
        }
      end
    end
  end
  if next(modifiers) ~= nil then
    style.modifiers = M.key_set(modifiers)
  end
  if not style.fg and not style.bg and not style.underline and not style.modifiers then
    return nil
  end
  return M.to_toml(style)
end

function M.to_rgb(color)
  if type(color) == "string" then
    return color
  elseif type(color) == "number" then
    return string.format("#%06x", color)
  end
end

function M.key_set(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

function M.to_toml(style)
  local buffer = {}
  M.insert_as_toml(buffer, style)
  return table.concat(buffer, "")
end

function M.insert_as_toml(buffer, x)
  if type(x) == "table" then
    if next(x) == nil then
      return
    end
    if M.is_array(x) then
      table.insert(buffer, "[")
      for _, v in pairs(x) do
        M.insert_as_toml(buffer, v)
        table.insert(buffer, ", ")
      end
      table.remove(buffer)
      table.insert(buffer, "]")
    else
      table.insert(buffer, "{ ")
      for k, v in M.pairsByKeys(x) do
        table.insert(buffer, string.format("%s = ", k))
        M.insert_as_toml(buffer, v)
        table.insert(buffer, ", ")
      end
      table.remove(buffer)
      table.insert(buffer, " }")
    end
  elseif type(x) == "string" then
    table.insert(buffer, "\"" .. x .. "\"")
  elseif type(x) == "number" then
    -- Colors from nvim_get_hl arrive as 24-bit RGB ints; emit as quoted hex.
    table.insert(buffer, string.format("\"#%06x\"", x))
  elseif type(x) ~= nil then
    table.insert(buffer, tostring(x))
  end
end

function M.is_array(t)
  local i = 0
  for _ in pairs(t) do
    i = i + 1
    if t[i] == nil then
      return false
    end
  end
  return true
end

return M
