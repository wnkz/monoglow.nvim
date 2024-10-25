local config = require("monoglow.config")

local M = {}

---@param opts? monoglow.Config
function M.load(opts)
  opts = require("monoglow.config").extend(opts)
  return require("monoglow.theme").setup(opts)
end

M.setup = config.setup

return M
