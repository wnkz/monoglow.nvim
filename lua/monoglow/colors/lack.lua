local ret = vim.deepcopy(require("monoglow.colors.z"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
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
