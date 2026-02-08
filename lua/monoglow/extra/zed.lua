local util = require("monoglow.util")

local M = {}

-- Convert #rrggbb to #rrggbbff (Zed requires 8-char hex with alpha)
local function hex8(color)
  if color and color:match("^#%x%x%x%x%x%x$") then
    return color .. "ff"
  end
  return color
end

-- Convert #rrggbb to #rrggbbXX with custom alpha (00-ff)
local function hex8a(color, alpha)
  if color and color:match("^#%x%x%x%x%x%x$") then
    return color .. alpha
  end
  return color
end

-- Generate a single theme's style object
---@param colors ColorScheme
local function generate_style(colors)
  return {
    -- Background colors
    ["background"] = hex8(colors.bg),
    ["elevated_surface.background"] = hex8(colors.bg_popup),
    ["surface.background"] = hex8(colors.bg_statusline),
    ["panel.background"] = hex8(colors.bg_statusline),
    ["panel.focused_border"] = hex8(colors.glow),

    -- Borders
    ["border"] = hex8(colors.border),
    ["border.variant"] = hex8(colors.gray3),
    ["border.focused"] = hex8(colors.glow),
    ["border.selected"] = hex8(colors.glow),
    ["border.transparent"] = "#00000000",
    ["border.disabled"] = hex8(colors.gray3),

    -- Text colors
    ["text"] = hex8(colors.fg),
    ["text.muted"] = hex8(colors.gray7),
    ["text.placeholder"] = hex8(colors.gray5),
    ["text.disabled"] = hex8(colors.gray4),
    ["text.accent"] = hex8(colors.glow),

    -- Icon colors
    ["icon"] = hex8(colors.fg),
    ["icon.muted"] = hex8(colors.gray7),
    ["icon.disabled"] = hex8(colors.gray4),
    ["icon.placeholder"] = hex8(colors.gray5),
    ["icon.accent"] = hex8(colors.glow),

    -- Element backgrounds (buttons, inputs, etc.)
    ["element.background"] = hex8(colors.gray3),
    ["element.hover"] = hex8(colors.gray4),
    ["element.active"] = hex8(colors.visual),
    ["element.selected"] = hex8(colors.visual),
    ["element.disabled"] = hex8(colors.gray2),

    -- Ghost elements (same bg as surface)
    ["ghost_element.background"] = "#00000000",
    ["ghost_element.hover"] = hex8(colors.cur_line),
    ["ghost_element.active"] = hex8(colors.visual),
    ["ghost_element.selected"] = hex8(colors.visual),
    ["ghost_element.disabled"] = hex8(colors.gray2),

    ["drop_target.background"] = hex8a(colors.glow, "40"),

    -- Status bar, title bar, toolbar
    ["status_bar.background"] = hex8(colors.bg_statusline),
    ["title_bar.background"] = hex8(colors.bg),
    ["title_bar.inactive_background"] = hex8(colors.bg),
    ["toolbar.background"] = hex8(colors.bg),

    -- Tab bar
    ["tab_bar.background"] = hex8(colors.bg_statusline),
    ["tab.inactive_background"] = hex8(colors.bg_statusline),
    ["tab.active_background"] = hex8(colors.bg),

    -- Search: match Neovim's IncSearch (active) and Search (other matches)
    -- Zed only supports background colors, not foreground
    ["search.match_background"] = hex8a(colors.glow, "50"),
    ["search.active_match_background"] = hex8a(colors.glow, "80"),

    -- Scrollbar
    ["scrollbar.thumb.background"] = hex8a(colors.gray5, "40"),
    ["scrollbar.thumb.hover_background"] = hex8a(colors.gray5, "60"),
    ["scrollbar.thumb.border"] = hex8(colors.gray3),
    ["scrollbar.track.background"] = "#00000000",
    ["scrollbar.track.border"] = hex8(colors.gray2),

    -- Editor
    ["editor.foreground"] = hex8(colors.fg),
    ["editor.background"] = hex8(colors.bg),
    ["editor.gutter.background"] = hex8(colors.bg),
    ["editor.subheader.background"] = hex8(colors.bg_statusline),
    ["editor.active_line.background"] = hex8(colors.cur_line),
    ["editor.highlighted_line.background"] = hex8(colors.cur_line),
    ["editor.line_number"] = hex8(colors.gray4),
    ["editor.hover_line_number"] = hex8(colors.gray6),
    ["editor.active_line_number"] = hex8(colors.cur_line_nr),
    ["editor.invisible"] = hex8(colors.special.whitespace),
    ["editor.wrap_guide"] = hex8a(colors.gray3, "40"),
    ["editor.active_wrap_guide"] = hex8a(colors.gray4, "60"),
    ["editor.indent_guide"] = hex8(colors.gray3),
    ["editor.indent_guide_active"] = hex8(colors.gray4),
    ["editor.document_highlight.read_background"] = hex8a(colors.visual, "40"),
    ["editor.document_highlight.write_background"] = hex8a(colors.visual, "66"),
    ["editor.document_highlight.bracket_background"] = hex8a(colors.gray5, "c0"),

    -- Link
    ["link_text.hover"] = hex8(colors.glow),

    -- Version control
    ["created"] = hex8(colors.git.add),
    ["created.background"] = hex8a(colors.diff.add, "40"),
    ["created.border"] = hex8a(colors.git.add, "60"),
    ["modified"] = hex8(colors.git.change),
    ["modified.background"] = hex8a(colors.diff.change, "40"),
    ["modified.border"] = hex8a(colors.git.change, "60"),
    ["deleted"] = hex8(colors.git.delete),
    ["deleted.background"] = hex8a(colors.diff.delete, "40"),
    ["deleted.border"] = hex8a(colors.git.delete, "60"),
    ["conflict"] = hex8(colors.warning),
    ["conflict.background"] = hex8a(colors.warning, "20"),
    ["conflict.border"] = hex8a(colors.warning, "60"),
    ["renamed"] = hex8(colors.info),
    ["renamed.background"] = hex8a(colors.info, "20"),
    ["renamed.border"] = hex8a(colors.info, "60"),

    -- Version control (git gutter and inline diff)
    ["version_control.added"] = hex8(colors.git.add),
    ["version_control.modified"] = hex8(colors.git.change),
    ["version_control.deleted"] = hex8(colors.git.delete),
    ["version_control.word_added"] = hex8a(colors.git.add, "60"),
    ["version_control.word_deleted"] = hex8a(colors.git.delete, "60"),
    ["version_control.conflict_marker.ours"] = hex8a(colors.info, "1a"),
    ["version_control.conflict_marker.theirs"] = hex8a(colors.warning, "1a"),

    -- Diagnostics
    ["error"] = hex8(colors.error),
    ["error.background"] = hex8a(colors.error, "20"),
    ["error.border"] = hex8a(colors.error, "60"),
    ["warning"] = hex8(colors.warning),
    ["warning.background"] = hex8a(colors.warning, "20"),
    ["warning.border"] = hex8a(colors.warning, "60"),
    ["info"] = hex8(colors.info),
    ["info.background"] = hex8a(colors.info, "20"),
    ["info.border"] = hex8a(colors.info, "60"),
    ["hint"] = hex8(colors.hint),
    ["hint.background"] = hex8a(colors.hint, "20"),
    ["hint.border"] = hex8a(colors.hint, "60"),
    ["success"] = hex8(colors.ok),
    ["success.background"] = hex8a(colors.ok, "20"),
    ["success.border"] = hex8a(colors.ok, "60"),

    -- Other statuses
    ["hidden"] = hex8(colors.gray5),
    ["hidden.background"] = hex8(colors.bg),
    ["hidden.border"] = hex8(colors.gray3),
    ["ignored"] = hex8(colors.gray5),
    ["ignored.background"] = hex8(colors.bg),
    ["ignored.border"] = hex8(colors.gray3),
    ["unreachable"] = hex8(colors.gray5),
    ["unreachable.background"] = hex8(colors.bg),
    ["unreachable.border"] = hex8(colors.gray3),
    ["predictive"] = hex8(colors.gray5),
    ["predictive.background"] = hex8a(colors.gray3, "40"),
    ["predictive.border"] = hex8(colors.gray4),

    -- Terminal
    ["terminal.background"] = hex8(colors.bg),
    ["terminal.foreground"] = hex8(colors.fg),
    ["terminal.bright_foreground"] = hex8(colors.white),
    ["terminal.dim_foreground"] = hex8(colors.gray6),
    ["terminal.ansi.black"] = hex8(colors.terminal.black),
    ["terminal.ansi.bright_black"] = hex8(colors.terminal.black_bright),
    ["terminal.ansi.dim_black"] = hex8(colors.gray2),
    ["terminal.ansi.red"] = hex8(colors.terminal.red),
    ["terminal.ansi.bright_red"] = hex8(colors.terminal.red_bright),
    ["terminal.ansi.dim_red"] = hex8(util.darken(colors.terminal.red, 0.7)),
    ["terminal.ansi.green"] = hex8(colors.terminal.green),
    ["terminal.ansi.bright_green"] = hex8(colors.terminal.green_bright),
    ["terminal.ansi.dim_green"] = hex8(util.darken(colors.terminal.green, 0.7)),
    ["terminal.ansi.yellow"] = hex8(colors.terminal.yellow),
    ["terminal.ansi.bright_yellow"] = hex8(colors.terminal.yellow_bright),
    ["terminal.ansi.dim_yellow"] = hex8(util.darken(colors.terminal.yellow, 0.7)),
    ["terminal.ansi.blue"] = hex8(colors.terminal.blue),
    ["terminal.ansi.bright_blue"] = hex8(colors.terminal.blue_bright),
    ["terminal.ansi.dim_blue"] = hex8(util.darken(colors.terminal.blue, 0.7)),
    ["terminal.ansi.magenta"] = hex8(colors.terminal.magenta),
    ["terminal.ansi.bright_magenta"] = hex8(colors.terminal.magenta_bright),
    ["terminal.ansi.dim_magenta"] = hex8(util.darken(colors.terminal.magenta, 0.7)),
    ["terminal.ansi.cyan"] = hex8(colors.terminal.cyan),
    ["terminal.ansi.bright_cyan"] = hex8(colors.terminal.cyan_bright),
    ["terminal.ansi.dim_cyan"] = hex8(util.darken(colors.terminal.cyan, 0.7)),
    ["terminal.ansi.white"] = hex8(colors.terminal.white),
    ["terminal.ansi.bright_white"] = hex8(colors.terminal.white_bright),
    ["terminal.ansi.dim_white"] = hex8(colors.gray7),

    -- Players (for collaboration)
    ["players"] = {
      {
        cursor = hex8(colors.glow),
        background = hex8(colors.glow),
        selection = hex8a(colors.glow, "3d"),
      },
      {
        cursor = hex8(colors.lack),
        background = hex8(colors.lack),
        selection = hex8a(colors.lack, "3d"),
      },
      {
        cursor = hex8(colors.luster),
        background = hex8(colors.luster),
        selection = hex8a(colors.luster, "3d"),
      },
      {
        cursor = hex8(colors.blue2),
        background = hex8(colors.blue2),
        selection = hex8a(colors.blue2, "3d"),
      },
      {
        cursor = hex8(colors.terminal.magenta_bright),
        background = hex8(colors.terminal.magenta_bright),
        selection = hex8a(colors.terminal.magenta_bright, "3d"),
      },
      {
        cursor = hex8(colors.terminal.red),
        background = hex8(colors.terminal.red),
        selection = hex8a(colors.terminal.red, "3d"),
      },
      {
        cursor = hex8(colors.terminal.yellow_bright),
        background = hex8(colors.terminal.yellow_bright),
        selection = hex8a(colors.terminal.yellow_bright, "3d"),
      },
      {
        cursor = hex8(colors.terminal.green_bright),
        background = hex8(colors.terminal.green_bright),
        selection = hex8a(colors.terminal.green_bright, "3d"),
      },
    },

    -- Syntax highlighting
    ["syntax"] = {
      ["attribute"] = { color = hex8(colors.syntax.property) },
      ["boolean"] = { color = hex8(colors.syntax.boolean) },
      ["comment"] = { color = hex8(colors.syntax.comment), font_style = "italic" },
      ["comment.doc"] = { color = hex8(colors.syntax.comment) },
      ["constant"] = { color = hex8(colors.syntax.const) },
      ["constructor"] = { color = hex8(colors.syntax.func_def) },
      ["embedded"] = { color = hex8(colors.syntax.string_escape) },
      ["emphasis"] = { color = hex8(colors.fg), font_style = "italic" },
      ["emphasis.strong"] = { color = hex8(colors.fg), font_weight = 700 },
      ["enum"] = { color = hex8(colors.syntax.type) },
      ["function"] = { color = hex8(colors.syntax.func_def) },
      ["function.builtin"] = { color = hex8(colors.syntax.builtin) },
      ["hint"] = { color = hex8(colors.hint) },
      ["keyword"] = { color = hex8(colors.syntax.keyword) },
      ["label"] = { color = hex8(colors.syntax.property) },
      ["link_text"] = { color = hex8(colors.glow), font_style = "italic" },
      ["link_uri"] = { color = hex8(colors.glow) },
      ["namespace"] = { color = hex8(colors.syntax.type) },
      ["number"] = { color = hex8(colors.syntax.const) },
      ["operator"] = { color = hex8(colors.glow) },
      ["predictive"] = { color = hex8(colors.gray5), font_style = "italic" },
      ["preproc"] = { color = hex8(colors.syntax.keyword) },
      ["primary"] = { color = hex8(colors.fg) },
      ["property"] = { color = hex8(colors.syntax.property) },
      ["punctuation"] = { color = hex8(colors.syntax.punctuation) },
      ["punctuation.bracket"] = { color = hex8(colors.syntax.punctuation) },
      ["punctuation.delimiter"] = { color = hex8(colors.syntax.punctuation) },
      ["punctuation.list_marker"] = { color = hex8(colors.glow) },
      ["punctuation.special"] = { color = hex8(colors.syntax.string_escape) },
      ["string"] = { color = hex8(colors.syntax.string) },
      ["string.escape"] = { color = hex8(colors.syntax.string_escape) },
      ["string.regex"] = { color = hex8(colors.syntax.string_escape) },
      ["string.special"] = { color = hex8(colors.syntax.string_escape) },
      ["string.special.symbol"] = { color = hex8(colors.syntax.const) },
      ["tag"] = { color = hex8(colors.syntax.tag) },
      ["text.literal"] = { color = hex8(colors.syntax.string) },
      ["title"] = { color = hex8(colors.title), font_weight = 700 },
      ["type"] = { color = hex8(colors.syntax.type) },
      ["variable"] = { color = hex8(colors.syntax.var) },
      ["variable.special"] = { color = hex8(colors.syntax.var_builtin) },
      ["variant"] = { color = hex8(colors.syntax.const) },
    },

    -- Vim mode colors (status bar indicator)
    ["vim.normal.background"] = hex8(colors.mode.normal.bg),
    ["vim.normal.foreground"] = hex8(colors.mode.normal.fg),
    ["vim.insert.background"] = hex8(colors.mode.insert.bg),
    ["vim.insert.foreground"] = hex8(colors.mode.insert.fg),
    ["vim.visual.background"] = hex8(colors.mode.visual.bg),
    ["vim.visual.foreground"] = hex8(colors.mode.visual.fg),
    ["vim.visual_line.background"] = hex8(colors.mode.visual.bg),
    ["vim.visual_line.foreground"] = hex8(colors.mode.visual.fg),
    ["vim.visual_block.background"] = hex8(colors.mode.visual.bg),
    ["vim.visual_block.foreground"] = hex8(colors.mode.visual.fg),
    ["vim.replace.background"] = hex8(colors.mode.replace.bg),
    ["vim.replace.foreground"] = hex8(colors.mode.replace.fg),
    ["vim.helix_normal.background"] = hex8(colors.mode.normal.bg),
    ["vim.helix_normal.foreground"] = hex8(colors.mode.normal.fg),
    ["vim.helix_select.background"] = hex8(colors.mode.visual.bg),
    ["vim.helix_select.foreground"] = hex8(colors.mode.visual.fg),
  }
end

-- Encode a Lua table to JSON string with proper formatting
---@param tbl table
---@param indent number?
---@return string
local function json_encode(tbl, indent)
  indent = indent or 0
  local spaces = string.rep("  ", indent)
  local next_spaces = string.rep("  ", indent + 1)

  if tbl[1] ~= nil or next(tbl) == nil then
    -- Array or empty table
    if #tbl == 0 then
      return "[]"
    end
    local items = {}
    for _, v in ipairs(tbl) do
      if type(v) == "table" then
        table.insert(items, json_encode(v, indent + 1))
      elseif type(v) == "string" then
        table.insert(items, '"' .. v .. '"')
      elseif type(v) == "number" then
        table.insert(items, tostring(v))
      elseif type(v) == "boolean" then
        table.insert(items, v and "true" or "false")
      elseif v == nil then
        table.insert(items, "null")
      end
    end
    return "[\n" .. next_spaces .. table.concat(items, ",\n" .. next_spaces) .. "\n" .. spaces .. "]"
  else
    -- Object
    local keys = {}
    for k in pairs(tbl) do
      table.insert(keys, k)
    end
    table.sort(keys)

    local items = {}
    for _, k in ipairs(keys) do
      local v = tbl[k]
      local key_str = '"' .. k .. '"'
      local val_str
      if type(v) == "table" then
        val_str = json_encode(v, indent + 1)
      elseif type(v) == "string" then
        val_str = '"' .. v .. '"'
      elseif type(v) == "number" then
        val_str = tostring(v)
      elseif type(v) == "boolean" then
        val_str = v and "true" or "false"
      elseif v == nil then
        val_str = "null"
      end
      table.insert(items, key_str .. ": " .. val_str)
    end
    return "{\n" .. next_spaces .. table.concat(items, ",\n" .. next_spaces) .. "\n" .. spaces .. "}"
  end
end

--- Generate the complete Zed theme family
---@param all_colors table<string, ColorScheme> Map of style name to colors
---@return string JSON content
function M.generate(all_colors)
  local style_names = {
    z = "Mono Glow",
    void = "Mono Glow Void",
    lack = "Mono Glow Lack",
    light = "Mono Glow Light",
  }

  local themes = {}
  -- Ensure consistent order: z, void, lack, light
  for _, style in ipairs({ "z", "void", "lack", "light" }) do
    local colors = all_colors[style]
    if colors then
      table.insert(themes, {
        name = style_names[style],
        appearance = colors._appearance or "dark",
        style = generate_style(colors),
      })
    end
  end

  local theme_family = {
    ["$schema"] = "https://zed.dev/schema/themes/v0.2.0.json",
    name = "Mono Glow",
    author = "wnkz",
    themes = themes,
  }

  return json_encode(theme_family)
end

return M
