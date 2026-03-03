#!/usr/bin/env bash
# Display all 16 ANSI terminal colors

printf "\n"

# Color names
names=("black" "red" "green" "yellow" "blue" "magenta" "cyan" "white")

# Normal colors (background blocks)
printf " Normal  "
for i in {0..7}; do
  printf "\033[48;5;${i}m    \033[0m "
done
printf "\n"

# Bright colors (background blocks)
printf " Bright  "
for i in {8..15}; do
  printf "\033[48;5;${i}m    \033[0m "
done
printf "\n\n"

# Normal foreground text
printf " Normal  "
for i in {0..7}; do
  printf "\033[3${i}m%-5s\033[0m" "${names[$i]}"
done
printf "\n"

# Bright foreground text
printf " Bright  "
for i in {0..7}; do
  printf "\033[9${i}m%-5s\033[0m" "${names[$i]}"
done
printf "\n\n"
