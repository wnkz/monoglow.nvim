# VHS tape for light style screenshot
Require nvim

Source tapes/common/base-light.tape
Source tapes/common/size-regular.tape

Type "nvim -u tests/screenshot_init.lua code-samples/ziggzagg.zig"
Enter
Wait /@import/

Type ":colorscheme monoglow-light"
Enter

Type "21G42|"

Screenshot tapes/screenshots/screenshot-light.png
Sleep 10ms

Type ":qa!"
Enter
