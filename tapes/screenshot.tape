# VHS tape for README screenshots (monoglow-z)
# Outputs: tapes/screenshots/screenshot-readme.png, screenshot-mode-insert.png, screenshot-mode-visual.png
Require nvim

Source tapes/common/base.tape
Source tapes/common/size-readme.tape

Type "nvim -u tests/screenshot_init.lua code-samples/ziggzagg.zig"
Enter
Wait /@import/

# Apply colorscheme
Type ":colorscheme monoglow-z"
Enter

# Position cursor at line 21, column 42
Type "21G42|"

# Take main screenshot (NORMAL mode)
Screenshot tapes/screenshots/screenshot-readme.png
Sleep 10ms

# INSERT mode screenshot
Type "i"
Wait+Screen /INSERT/
Screenshot tapes/screenshots/screenshot-mode-insert.png
Sleep 10ms
Escape

# VISUAL mode screenshot (move to col 43 so visual mode shows 42)
Type "l"
Type "v"
Wait+Screen /VISUAL/
Screenshot tapes/screenshots/screenshot-mode-visual.png
Sleep 10ms
Escape

# Exit
Type ":qa!"
Enter
