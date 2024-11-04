local util = require("monoglow.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  local kitty = util.template(
    [[
# vim:ft=kitty

## name:      ${_style_name}
## author:    wnkz (https://github.com/wnkz)
## license:   APACHE-2.0
## upstream:  ${_upstream_url}

#: The basic colors

background ${bg}
foreground ${fg}
selection_background ${visual}
selection_foreground ${gray9}


#: Cursor colors

cursor ${fg}
cursor_text_color ${bg}


#: URL underline color when hovering with mouse

url_color ${lack}


#: kitty window border colors and terminal bell colors

active_border_color ${glow}


#: Tab bar colors

active_tab_background ${gray9}
active_tab_foreground ${black}
inactive_tab_background ${gray3}
inactive_tab_foreground ${fg_sidebar}
tab_bar_background none
tab_bar_margin_color none


#: The basic 16 colors

#: black
color0 ${terminal.black}
color8 ${terminal.black_bright}

#: red
color1 ${terminal.red}
color9 ${terminal.red_bright}

#: green
color2  ${terminal.green}
color10 ${terminal.green_bright}

#: yellow
color3  ${terminal.yellow}
color11 ${terminal.yellow_bright}

#: blue
color4  ${terminal.blue}
color12 ${terminal.blue_bright}

#: magenta
color5  ${terminal.magenta}
color13 ${terminal.magenta_bright}

#: cyan
color6  ${terminal.cyan}
color14 ${terminal.cyan_bright}

#: white
color7  ${terminal.white}
color15 ${terminal.white_bright}
]],
    colors
  )
  return kitty
end

return M
