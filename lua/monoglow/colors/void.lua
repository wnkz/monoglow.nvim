local ret = vim.deepcopy(require("monoglow.colors.z"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
  gray1 = "#1e1e1e",
  gray2 = "#2a2a2a",
  gray3 = "#303030",
  gray4 = "#404040",
  gray5 = "#585858",
  gray6 = "#a1a1a1",
  gray7 = "#b1b1b1",
  gray8 = "#d1d1d1",
  gray9 = "#e1e1e1",

  fg = "#c0c0c0",
  bg = "#1c1c1c",

  special = {
    comment = "#585858",
  },
})
