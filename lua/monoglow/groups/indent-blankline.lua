local M = {}

M.url = "https://github.com/lukas-reineke/indent-blankline.nvim"

function M.get(c, opts)
  return {
    IndentBlanklineChar        = { fg = c.syntax.comment, nocombine = true },
    IndentBlanklineContextChar = { fg = c.fg, nocombine = true },
    IblIndent                  = { fg = c.syntax.comment, nocombine = true },
    IblScope                   = { fg = c.fg, nocombine = true },
  }
end

return M
