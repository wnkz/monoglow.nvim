local util = require("monoglow.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  local theme = util.template(
    [[
background = ${bg}
foreground = ${fg}
selection-background = ${visual}
selection-foreground = ${gray9}
cursor-color = ${fg}

#: black
palette = 0=${terminal.black}
palette = 8=${terminal.black_bright}

#: red
palette = 1=${terminal.red}
palette = 9=${terminal.red_bright}

#: green
palette = 2=${terminal.green}
palette = 10=${terminal.green_bright}

#: yellow
palette = 3=${terminal.yellow}
palette = 11=${terminal.yellow_bright}

#: blue
palette = 4=${terminal.blue}
palette = 12=${terminal.blue_bright}

#: magenta
palette = 5=${terminal.magenta}
palette = 13=${terminal.magenta_bright}

#: cyan
palette = 6=${terminal.cyan}
palette = 14=${terminal.cyan_bright}

#: white
palette = 7=${terminal.white}
palette = 15=${terminal.white_bright}
]],
    colors
  )
  return theme
end

return M
