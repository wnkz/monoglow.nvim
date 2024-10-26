local ret = vim.deepcopy(require("monoglow.colors.z"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
  gray1 = "#080808",
  gray2 = "#191919",
  gray3 = "#2a2a2a",
  gray4 = "#444444",
  gray5 = "#555555",
  gray6 = "#7a7a7a",
  gray7 = "#aaaaaa",
  gray8 = "#cccccc",
  gray9 = "#dddddd",

  fg = ret.gray8,
  bg = "#101010",

  special = {
    comment = "#474747",
    exception = "#505050",
    keyword = "#727272",
    param = "#8e8e8e",
    whitespace = "#202020",
  },
})
