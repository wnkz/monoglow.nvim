local ret = vim.deepcopy(require("monoglow.colors.z"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
  -- Inverted gray scale (gray1=lightest, gray10=darkest)
  gray1 = "#f1f1f1",
  gray2 = "#e2e2e2",
  gray3 = "#d0d0d0",
  gray4 = "#b0b0b0",
  gray5 = "#909090",
  gray6 = "#707070",
  gray7 = "#555555",
  gray8 = "#3a3a3a",
  gray9 = "#252525",
  gray10 = "#151515",
  white = "#000000",

  fg = "#3a3a3a",
  bg = "#f0f0f0",
  glow = "#059669",

  blue1 = "#3d7a7a",
  blue2 = "#2e8a8a",
  lack = "#506070",
  luster = "#2a5e5e",

  git = {
    add = "#2d6e3a",
    change = "#8a7a2e",
    delete = "#9e3a3a",
  },

  -- Darker diagnostic colors for light bg
  light_blue = "#1a6e99",
  light_cyan = "#1a8a89",
  light_green = "#2a7a40",
  light_magenta = "#8a3a8a",
  light_red = "#c04040",
  light_yellow = "#9a7a20",

  is_light = true,

  special = {
    comment = "#a0a0a0",
    whitespace = "#d8d8d8",
  },
})
