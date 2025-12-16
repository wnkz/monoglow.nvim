# VHS tape for style screenshots (z, lack, void)
# Outputs: tapes/screenshots/screenshot-z.png, screenshot-lack.png, screenshot-void.png
Require nvim

Source tapes/common/base.tape
Source tapes/common/size-regular.tape

Type "nvim -u tests/screenshot_init.lua code-samples/ziggzagg.zig"
Enter
Wait /@import/

# Apply monoglow-z colorscheme
Type ":colorscheme monoglow-z"
Enter

# Position cursor at line 21, column 42
Type "21G42|"

# Take screenshot for monoglow-z
Screenshot tapes/screenshots/screenshot-z.png
Sleep 10ms

# Switch to monoglow-lack
Type ":colorscheme monoglow-lack"
Enter
Sleep 100ms

# Take screenshot for monoglow-lack
Screenshot tapes/screenshots/screenshot-lack.png
Sleep 10ms

# Switch to monoglow-void
Type ":colorscheme monoglow-void"
Enter
Sleep 100ms

# Take screenshot for monoglow-void
Screenshot tapes/screenshots/screenshot-void.png
Sleep 10ms

# Exit
Type ":qa!"
Enter
