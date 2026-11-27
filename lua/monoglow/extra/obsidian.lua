local util = require("monoglow.util")

local M = {}

---@param hex string
---@return number, number, number
local function to_rgb(hex)
  hex = hex:lower()
  return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
end

-- "#rrggbb" -> "r, g, b" (Obsidian's --color-*-rgb format)
---@param hex string
local function rgb_triplet(hex)
  local r, g, b = to_rgb(hex)
  return string.format("%d, %d, %d", r, g, b)
end

-- Percentage alpha (stylelint alpha-value-notation)
---@param alpha number
local function pct(alpha)
  return math.floor(alpha * 100 + 0.5) .. "%"
end

-- Modern rgb() with alpha (stylelint color-function-notation)
---@param hex string
---@param alpha number
local function rgba(hex, alpha)
  local r, g, b = to_rgb(hex)
  return string.format("rgb(%d %d %d / %s)", r, g, b, pct(alpha))
end

-- "#aabbcc" -> "#abc" when possible (stylelint color-hex-length)
---@param value string
local function short_hex(value)
  local r1, r2, g1, g2, b1, b2 = value:match("^#(%x)(%x)(%x)(%x)(%x)(%x)$")
  if r1 and r1 == r2 and g1 == g2 and b1 == b2 then
    return "#" .. r1 .. g1 .. b1
  end
  return value
end

-- "#rrggbb" -> h (deg), s (%), l (%)
---@param hex string
local function to_hsl(hex)
  local r, g, b = to_rgb(hex)
  r, g, b = r / 255, g / 255, b / 255
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local h, s
  local l = (max + min) / 2
  if max == min then
    h, s = 0, 0
  else
    local d = max - min
    s = l > 0.5 and d / (2 - max - min) or d / (max + min)
    if max == r then
      h = (g - b) / d + (g < b and 6 or 0)
    elseif max == g then
      h = (b - r) / d + 2
    else
      h = (r - g) / d + 4
    end
    h = h / 6
  end
  return math.floor(h * 360 + 0.5), math.floor(s * 1000 + 0.5) / 10, math.floor(l * 1000 + 0.5) / 10
end

-- Accent with alpha, derived from Obsidian's accent HSL so a user-picked
-- accent color (Settings > Appearance) still propagates.
---@param alpha number
local function accent_a(alpha)
  return string.format("hsl(var(--accent-h) var(--accent-s) var(--accent-l) / %s)", pct(alpha))
end

-- Ordered list of { variable, value } for one style
---@param c ColorScheme
---@return string[][]
local function variables(c)
  local h, s, l = to_hsl(c.glow)
  local orange = util.blend(c.light_red, 0.5, c.light_yellow)
  local pink = util.blend(c.light_magenta, 0.5, c.light_red)

  return {
    { "/* Accent (glow) */" },
    { "--accent-h", tostring(h) },
    { "--accent-s", s .. "%" },
    { "--accent-l", l .. "%" },

    { "/* Base scale */" },
    { "--color-base-00", c.bg },
    { "--color-base-05", c.bg_statusline },
    { "--color-base-10", c.bg_popup },
    { "--color-base-20", c.bg_menu },
    { "--color-base-25", c.cur_line },
    { "--color-base-30", c.gray3 },
    { "--color-base-35", c.gray4 },
    { "--color-base-40", c.gray5 },
    { "--color-base-50", c.gray5 },
    { "--color-base-60", c.gray6 },
    { "--color-base-70", c.gray7 },
    { "--color-base-100", c.fg },

    { "/* Extended colors (callouts, canvas, etc.) */" },
    { "--color-red", c.error },
    { "--color-red-rgb", rgb_triplet(c.error) },
    { "--color-orange", orange },
    { "--color-orange-rgb", rgb_triplet(orange) },
    { "--color-yellow", c.warning },
    { "--color-yellow-rgb", rgb_triplet(c.warning) },
    { "--color-green", c.ok },
    { "--color-green-rgb", rgb_triplet(c.ok) },
    { "--color-cyan", c.info },
    { "--color-cyan-rgb", rgb_triplet(c.info) },
    { "--color-blue", c.light_blue },
    { "--color-blue-rgb", rgb_triplet(c.light_blue) },
    { "--color-purple", c.light_magenta },
    { "--color-purple-rgb", rgb_triplet(c.light_magenta) },
    { "--color-pink", pink },
    { "--color-pink-rgb", rgb_triplet(pink) },
    { "--monoglow-glow-rgb", rgb_triplet(c.glow) },
    { "--monoglow-gray-rgb", rgb_triplet(c.gray6) },

    { "/* Backgrounds */" },
    { "--background-primary", c.bg },
    { "--background-primary-alt", c.bg_statusline },
    { "--background-secondary", c.bg_statusline },
    { "--background-secondary-alt", c.bg_menu },
    { "--background-modifier-hover", c.cur_line },
    { "--background-modifier-active-hover", c.visual },
    { "--background-modifier-border", c.gray3 },
    { "--background-modifier-border-hover", c.gray4 },
    { "--background-modifier-border-focus", "var(--color-accent)" },
    { "--background-modifier-form-field", c.bg_popup },
    { "--background-modifier-error", c.error },
    { "--background-modifier-error-hover", c.error },
    { "--background-modifier-success", c.ok },

    { "/* Text */" },
    { "--text-normal", c.fg },
    { "--text-muted", c.gray7 },
    { "--text-faint", c.gray5 },
    { "--text-on-accent", c.black },
    { "--text-on-accent-inverted", c.fg },
    { "--text-accent", "var(--color-accent)" },
    { "--text-accent-hover", "var(--color-accent-1)" },
    { "--text-error", c.error },
    { "--text-warning", c.warning },
    { "--text-success", c.ok },
    { "--text-selection", accent_a(0.2) },
    { "--text-highlight-bg", accent_a(0.25) },
    { "--text-highlight-bg-active", accent_a(0.5) },
    { "--caret-color", "var(--color-accent)" },

    { "/* Interactive */" },
    { "--interactive-normal", c.bg_popup },
    { "--interactive-hover", c.gray3 },
    { "--icon-color", c.icon },
    { "--icon-color-hover", c.fg },
    { "--icon-color-active", "var(--color-accent)" },
    { "--icon-color-focused", c.fg },

    { "/* Headings */" },
    { "--inline-title-color", c.gray10 },
    { "--h1-color", c.gray10 },
    { "--h2-color", c.gray9 },
    { "--h3-color", c.gray8 },
    { "--h4-color", c.gray7 },
    { "--h5-color", c.gray6 },
    { "--h6-color", c.gray6 },
    { "--heading-formatting", c.gray5 },

    { "/* Inline formatting */" },
    { "--bold-color", c.gray10 },
    { "--italic-color", c.fg },
    { "--hr-color", c.gray3 },

    { "/* Links */" },
    { "--link-color", "var(--color-accent)" },
    { "--link-color-hover", "var(--color-accent-1)" },
    { "--link-unresolved-color", "var(--color-accent)" },
    { "--link-unresolved-opacity", "0.6" },
    { "--link-unresolved-decoration-color", accent_a(0.3) },
    { "--link-external-color", c.blue2 },
    { "--link-external-color-hover", c.blue1 },

    { "/* Lists & checkboxes */" },
    { "--list-marker-color", c.gray5 },
    { "--list-marker-color-hover", c.gray7 },
    { "--list-marker-color-collapsed", "var(--color-accent)" },
    { "--checkbox-color", "var(--color-accent)" },
    { "--checkbox-color-hover", "var(--color-accent-1)" },
    { "--checkbox-border-color", c.gray5 },
    { "--checkbox-border-color-hover", c.gray7 },
    { "--checkbox-marker-color", c.bg },
    { "--checklist-done-color", c.gray5 },

    { "/* Blockquotes */" },
    { "--blockquote-border-color", c.gray4 },
    { "--blockquote-color", c.gray7 },

    { "/* Tags */" },
    { "--tag-color", "var(--color-accent)" },
    { "--tag-color-hover", "var(--color-accent-1)" },
    { "--tag-background", accent_a(0.1) },
    { "--tag-background-hover", accent_a(0.2) },
    { "--tag-border-color", accent_a(0.15) },
    { "--tag-border-color-hover", accent_a(0.3) },

    { "/* Code */" },
    { "--code-background", c.bg_statusline },
    { "--code-normal", c.fg },
    { "--code-comment", c.syntax.comment },
    { "--code-function", c.syntax.func_def },
    { "--code-important", "var(--color-accent)" },
    { "--code-keyword", c.syntax.keyword },
    { "--code-operator", "var(--color-accent)" },
    { "--code-property", c.syntax.property },
    { "--code-punctuation", c.syntax.punctuation },
    { "--code-string", c.syntax.string },
    { "--code-tag", c.syntax.tag },
    { "--code-value", c.syntax.boolean },

    { "/* Tables */" },
    { "--table-border-color", c.gray3 },
    { "--table-header-background", c.bg_statusline },
    { "--table-header-background-hover", c.cur_line },
    { "--table-row-alt-background", c.bg_statusline },

    { "/* Workspace chrome */" },
    { "--titlebar-background", c.bg_statusline },
    { "--titlebar-background-focused", c.bg_statusline },
    { "--titlebar-text-color", c.gray6 },
    { "--titlebar-text-color-focused", c.fg },
    { "--ribbon-background", c.bg_statusline },
    { "--ribbon-background-collapsed", c.bg },
    { "--tab-container-background", c.bg_statusline },
    { "--tab-background-active", c.bg },
    { "--tab-text-color", c.gray5 },
    { "--tab-text-color-focused", c.gray7 },
    { "--tab-text-color-focused-active", c.fg },
    { "--tab-text-color-focused-active-current", c.gray10 },
    { "--tab-outline-color", c.gray3 },
    { "--tab-divider-color", c.gray3 },
    { "--status-bar-background", c.bg_statusline },
    { "--status-bar-border-color", c.gray3 },
    { "--status-bar-text-color", c.gray6 },
    { "--divider-color", c.gray3 },
    { "--divider-color-hover", "var(--color-accent)" },
    { "--modal-border-color", c.border },
    { "--prompt-border-color", c.border },
    { "--scrollbar-bg", "transparent" },
    { "--scrollbar-thumb-bg", rgba(c.gray5, 0.25) },
    { "--scrollbar-active-thumb-bg", rgba(c.gray5, 0.4) },

    { "/* File explorer & navigation */" },
    { "--nav-item-color", c.gray7 },
    { "--nav-item-color-hover", c.fg },
    { "--nav-item-color-active", c.gray10 },
    { "--nav-item-color-selected", c.gray10 },
    { "--nav-item-background-hover", c.cur_line },
    { "--nav-item-background-active", c.visual },
    { "--nav-item-background-selected", accent_a(0.15) },
    { "--nav-collapse-icon-color", c.gray5 },
    { "--nav-collapse-icon-color-collapsed", c.gray5 },
    { "--nav-indentation-guide-color", c.gray3 },
    { "--indentation-guide-color", c.gray3 },
    { "--indentation-guide-color-active", c.gray4 },
    { "--collapse-icon-color", c.gray5 },
    { "--collapse-icon-color-collapsed", "var(--color-accent)" },

    { "/* Graph view */" },
    { "--graph-line", c.gray3 },
    { "--graph-node", c.gray6 },
    { "--graph-node-unresolved", c.gray4 },
    { "--graph-node-focused", "var(--color-accent)" },
    { "--graph-node-tag", c.blue2 },
    { "--graph-node-attachment", c.lack },
    { "--graph-text", c.fg },
  }
end

---@param selector string
---@param c ColorScheme
---@param label string
local function block(selector, c, label)
  local lines = { "/* " .. label .. " */", selector .. " {" }
  for i, v in ipairs(variables(c)) do
    if #v == 1 then
      if i > 1 then
        table.insert(lines, "")
      end
      table.insert(lines, "\t" .. v[1])
    else
      table.insert(lines, string.format("\t%s: %s;", v[1], short_hex(v[2])))
    end
  end
  table.insert(lines, "}")
  return table.concat(lines, "\n")
end

local header = [[
/*
 * Mono Glow for Obsidian
 * A dark, mostly monochrome colorscheme with a touch of glowing.
 * Part of monoglow.nvim: https://github.com/wnkz/monoglow.nvim
 *
 * Generated by `./scripts/build` from lua/monoglow/extra/obsidian.lua.
 * Do not edit this file manually.
 */

/* @settings

name: Mono Glow
id: monoglow
settings:
  -
    id: monoglow-dark-variant
    title: Dark variant
    description: Palette used when Obsidian is in dark mode
    type: class-select
    allowEmpty: false
    default: monoglow-z
    options:
      -
        label: Mono Glow
        value: monoglow-z
      -
        label: Mono Glow Void
        value: monoglow-void
      -
        label: Mono Glow Lack
        value: monoglow-lack

*/]]

local static = [[
/* Callouts: default/note callouts glow, quotes stay gray */
body {
	--callout-default: var(--monoglow-glow-rgb);
	--callout-quote: var(--monoglow-gray-rgb);
}

/* Square corners */
body {
	--radius-s: 0px;
	--radius-m: 0px;
	--radius-l: 0px;
	--input-radius: 0px;
	--tab-radius-active: 0px;
	--checkbox-radius: 0px;
	--toggle-radius: 0px;
	--toggle-thumb-radius: 0px;
	--slider-thumb-radius: 0px;
}

.workspace-tab-header.is-active::before,
.workspace-tab-header.is-active::after {
	display: none;
}

svg * {
	stroke-linecap: square;
	stroke-linejoin: miter;
	rx: 0;
	ry: 0;
}

.menu {
	padding: var(--size-2-1);
}

.menu-item {
	padding: var(--size-4-1) var(--size-4-2);
}

.menu-separator {
	margin: var(--size-2-1) calc(var(--size-2-1) * -1);
}]]

--- Generate the Obsidian theme.css (all styles in one file)
---@param all_colors table<string, ColorScheme> Map of style name to colors
---@return string
function M.generate(all_colors)
  local parts = {
    header,
    block(".theme-dark", all_colors.z, "Mono Glow (dark default)"),
    block(".theme-dark.monoglow-void", all_colors.void, "Mono Glow Void"),
    block(".theme-dark.monoglow-lack", all_colors.lack, "Mono Glow Lack"),
    block(".theme-light", all_colors.light, "Mono Glow Light"),
    static,
  }
  return table.concat(parts, "\n\n") .. "\n"
end

return M
