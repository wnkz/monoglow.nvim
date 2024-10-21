local M = {}

M.url = "https://github.com/stevearc/oil.nvim"

function M.get(c, opts)
  return {
    OilFile = { fg = c.fs.file },
    OilLink = { fg = c.fs.link },
    OilLinkTarget = "OilLink",
    OilSocket = { fg = c.fs.socket },
    OilCreate = { fg = c.git.add },
    OilCopy = { fg = c.git.add },
    OilRestore = { fg = c.git.add },
    OilDelete = { fg = c.git.delete },
    OilPurge = { fg = c.git.delete },
    OilTrash = { fg = c.git.delete },
    OilTrashSourcePath = { fg = c.git.delete },
    OilMove = { fg = c.git.change },
    OilChange = { fg = c.git.change },
  }
end

return M
