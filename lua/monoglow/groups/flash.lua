local M = {}

M.url = "https://github.com/folke/flash.nvim"

function M.get(c, opts)
  return {
    FlashBackdrop = { fg = c.gray6, bg = c.bg },
  }
end

return M
