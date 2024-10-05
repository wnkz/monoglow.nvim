local M = {
  module = "monoglow",
  colorscheme = "monoglow",
  opts = {},
  globals = { vim = vim },
}

function M.reset()
  local colors = require("monoglow.colors").setup()
  M.globals.colors = colors
  M.globals.c = colors
end

local function reload()
  for k in pairs(package.loaded) do
    if k:find("^" .. M.module) or k:find("^lualine%.themes%._monoglow") then
      package.loaded[k] = nil
    end
  end
  require(M.module).setup(M.opts)
  M.reset()
  local colorscheme = vim.g.colors_name or M.colorscheme
  colorscheme = colorscheme:find(M.colorscheme) and colorscheme or M.colorscheme
  vim.cmd.colorscheme(colorscheme)
end
reload = vim.schedule_wrap(reload)

local augroup = vim.api.nvim_create_augroup("colorscheme_dev", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = augroup,
  callback = reload,
})
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup,
  pattern = { "*/lua/" .. M.module .. "/**.lua", "*/lua/lualine/themes/**.lua" },
  callback = reload,
})

return {}
