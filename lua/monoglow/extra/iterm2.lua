local M = {}

local function hex_to_rgb(hex)
  local r = tonumber(hex:sub(2, 3), 16) / 255
  local g = tonumber(hex:sub(4, 5), 16) / 255
  local b = tonumber(hex:sub(6, 7), 16) / 255
  return r, g, b
end

local function color_entry(name, hex)
  local r, g, b = hex_to_rgb(hex)
  return string.format(
    [[	<key>%s</key>
	<dict>
		<key>Alpha Component</key>
		<real>1</real>
		<key>Blue Component</key>
		<real>%.17g</real>
		<key>Color Space</key>
		<string>sRGB</string>
		<key>Green Component</key>
		<real>%.17g</real>
		<key>Red Component</key>
		<real>%.17g</real>
	</dict>]],
    name,
    b,
    g,
    r
  )
end

--- @param colors ColorScheme
function M.generate(colors)
  local ansi_names = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }

  local entries = {}

  -- ANSI colors 0-7
  for i, name in ipairs(ansi_names) do
    table.insert(entries, color_entry("Ansi " .. (i - 1) .. " Color", colors.terminal[name]))
  end

  -- ANSI colors 8-15 (bright)
  for i, name in ipairs(ansi_names) do
    table.insert(entries, color_entry("Ansi " .. (i + 7) .. " Color", colors.terminal[name .. "_bright"]))
  end

  -- UI colors
  table.insert(entries, color_entry("Background Color", colors.bg))
  table.insert(entries, color_entry("Badge Color", colors.glow))
  table.insert(entries, color_entry("Bold Color", colors.fg))
  table.insert(entries, color_entry("Cursor Color", colors.fg))
  table.insert(entries, color_entry("Cursor Text Color", colors.bg))
  table.insert(entries, color_entry("Foreground Color", colors.fg))
  table.insert(entries, color_entry("Link Color", colors.lack))
  table.insert(entries, color_entry("Selected Text Color", colors.gray9))
  table.insert(entries, color_entry("Selection Color", colors.visual))

  return '<?xml version="1.0" encoding="UTF-8"?>\n'
    .. '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n'
    .. '<plist version="1.0">\n'
    .. "<dict>\n"
    .. table.concat(entries, "\n")
    .. "\n</dict>\n"
    .. "</plist>\n"
end

return M
