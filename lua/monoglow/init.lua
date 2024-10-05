local config = require("monoglow.config")

local M = {}

function M.load(opts)
  -- opts = config.extend(opts)
  opts = require("monoglow.config").extend(opts)
  return require("monoglow.theme").setup(opts)
end

M.setup = config.setup

return M
