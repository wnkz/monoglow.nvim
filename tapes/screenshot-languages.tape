# VHS tape for README screenshots (monoglow-z)
# Outputs: tapes/screenshots/screenshot-readme.png, screenshot-mode-insert.png, screenshot-mode-visual.png
Require nvim

Source tapes/common/base.tape
Source tapes/common/size-readme.tape

Type "nvim -u tests/screenshot_init.lua code-samples/ll.c"
Enter
Wait /#include/

# Apply colorscheme
Type ":colorscheme monoglow-z"
Enter

Screenshot tapes/screenshots/screenshot-c.png
Sleep 10ms

Type ":e code-samples/todo.py"
Enter
Wait /python3/
Sleep 100ms

Screenshot tapes/screenshots/screenshot-python.png
Sleep 10ms

Type ":e code-samples/fizzbuzz.rs"
Enter
Wait /Unlike/
Sleep 100ms

Screenshot tapes/screenshots/screenshot-rust.png
Sleep 10ms

# Exit
Type ":qa!"
Enter
