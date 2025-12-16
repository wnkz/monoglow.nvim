# VHS tape for custom glow color screenshot (#fd1b7c)
# Output: tapes/screenshots/screenshot-custom-glow.png
Require nvim

Source tapes/common/base.tape
Source tapes/common/size-readme.tape

Env MONOGLOW_GLOW "#fd1b7c"

Type "nvim -u tests/screenshot_init.lua code-samples/ziggzagg.zig"
Enter
Wait /@import/

# Apply colorscheme
Type ":colorscheme monoglow-z"
Enter

# Position cursor at line 21, column 42
Type "21G42|"

# Take screenshot
Screenshot tapes/screenshots/screenshot-custom-glow.png
Sleep 10ms

# Exit
Type ":qa!"
Enter
