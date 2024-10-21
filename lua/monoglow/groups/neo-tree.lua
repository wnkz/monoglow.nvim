local M = {}

M.url = "https://github.com/nvim-neo-tree/neo-tree.nvim"

function M.get(c, opts)
  return {
    NeoTreeFileName = { fg = c.fs.file },
    NeoTreeSymbolicLinkTarget = { fg = c.fs.link },
    NeoTreeGitUntracked = { fg = c.lack },
    NeoTreeGitConflict = { fg = c.lack },
  }
end

return M
