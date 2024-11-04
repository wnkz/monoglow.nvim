local util = require("monoglow.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  local kitty = util.template(
    [[
# vim:ft=kitty

## name:      ${_style_name}
## author:    wnkz (https://github.com/wnkz)
## upstream:  ${_upstream_url}
## license:   MIT

background ${bg}
foreground ${fg}
selection_background ${visual}
selection_foreground ${gray9}

cursor ${fg}
cursor_text_color ${bg}

url_color ${lack}

# Tabs
active_tab_background ${gray9}
active_tab_foreground ${black}
inactive_tab_background ${gray3}
inactive_tab_foreground ${fg_sidebar}

# Windows
active_border_color ${glow}

# The 16 terminal colors
# normal/bright

# black
color0 ${terminal.black}
color8 ${terminal.black_bright}

# red
color1 ${terminal.red}
color9 ${terminal.red_bright}

# green
color2  ${terminal.green}
color10 ${terminal.green_bright}

# yellow
color3  ${terminal.yellow}
color11 ${terminal.yellow_bright}

# blue
color4  ${terminal.blue}
color12 ${terminal.blue_bright}

# purple
color5  ${terminal.magenta}
color13 ${terminal.magenta_bright}

# cyan
color6  ${terminal.cyan}
color14 ${terminal.cyan_bright}

# white
color7  ${terminal.white}
color15 ${terminal.white_bright}
]],
    colors
  )
  return kitty
end

return M
