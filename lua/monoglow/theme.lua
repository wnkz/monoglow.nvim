local M = {}

function M.setup(opts)
  opts = require("monoglow.config").extend(opts)

  local colors = require("monoglow.colors").setup(opts)
  local groups = require("monoglow.groups").setup(colors, opts)

  -- only needed to clear when not the default colorscheme
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "monoglow"

  for group, hl in pairs(groups) do
    hl = type(hl) == "string" and { link = hl } or hl
    vim.api.nvim_set_hl(0, group, hl)
  end

  return colors, groups, opts
end

return M
