local M = {}

---@class monoglow.Config
M.defaults = {
  style = "z",
  glow = true,
  transparent = false,
  plugins = {
    auto = true,
  },
  lualine_bold = true,
  eob = false,
}

---@type monoglow.Config
M.options = nil

---@param options? monoglow.Config
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

---@param opts? monoglow.Config
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
