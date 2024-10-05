local M = {}

M.defaults = {
  glow = true,
  transparent = false,
  plugins = {
    auto = true,
  },
  lualine_bold = true,
  eob = false,
}

M.options = nil

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

function M.extend(opts)
  return opts and vim.tbl_deep_extend("force", {}, M.options, opts) or M.options
end

setmetatable(M, {
  __index = function(_, k)
    if k == "options" then
      return M.defaults
    end
  end,
})

return M
