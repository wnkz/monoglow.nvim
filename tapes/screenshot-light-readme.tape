# VHS tape for README screenshots (monoglow-light)
# Outputs: tapes/screenshots/screenshot-readme-light.png
Require nvim

Source tapes/common/base-light.tape
Source tapes/common/size-readme.tape

Type "nvim -u tests/screenshot_init.lua code-samples/ziggzagg.zig"
Enter
Wait /@import/

# Apply colorscheme
Type ":colorscheme monoglow-light"
Enter

# Position cursor at line 21, column 42
Type "21G42|"

# Take main screenshot (NORMAL mode)
Screenshot tapes/screenshots/screenshot-readme-light.png
Sleep 10ms

# Exit
Type ":qa!"
Enter
