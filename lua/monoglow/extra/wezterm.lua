local util = require("monoglow.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  local theme = util.template(
    [[
# WezTerm color scheme
# https://wezterm.org/config/appearance.html

[metadata]
name = "${_style_name}"
author = "wnkz (https://github.com/wnkz)"
origin_url = "${_upstream_url}"

[colors]
background = "${bg}"
foreground = "${fg}"
cursor_bg = "${fg}"
cursor_fg = "${bg}"
cursor_border = "${fg}"
selection_bg = "${visual}"
selection_fg = "${gray9}"

ansi = [
  "${terminal.black}",
  "${terminal.red}",
  "${terminal.green}",
  "${terminal.yellow}",
  "${terminal.blue}",
  "${terminal.magenta}",
  "${terminal.cyan}",
  "${terminal.white}",
]

brights = [
  "${terminal.black_bright}",
  "${terminal.red_bright}",
  "${terminal.green_bright}",
  "${terminal.yellow_bright}",
  "${terminal.blue_bright}",
  "${terminal.magenta_bright}",
  "${terminal.cyan_bright}",
  "${terminal.white_bright}",
]

[colors.tab_bar]
background = "${bg}"

[colors.tab_bar.active_tab]
bg_color = "${gray9}"
fg_color = "${black}"

[colors.tab_bar.inactive_tab]
bg_color = "${gray3}"
fg_color = "${fg_sidebar}"

[colors.tab_bar.inactive_tab_hover]
bg_color = "${gray4}"
fg_color = "${fg}"

[colors.tab_bar.new_tab]
bg_color = "${gray3}"
fg_color = "${fg_sidebar}"

[colors.tab_bar.new_tab_hover]
bg_color = "${gray4}"
fg_color = "${fg}"
]],
    colors
  )
  return theme
end

return M
