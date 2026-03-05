# VHS tape for terminal colors screenshot
# Output: tapes/screenshots/screenshot-terminal-colors.png
Require eza

Source tapes/common/base.tape

Set Width 1600
Set Height 800
Set Padding 10

# Use glow green prompt (ANSI green = glow in our theme)
Env PROMPT "%F{green}❯%f "

Type "eza -l"
Enter
Sleep 500ms

Screenshot tapes/screenshots/screenshot-terminal-colors.png
