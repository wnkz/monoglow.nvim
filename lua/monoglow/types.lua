---@class monoglow.Highlight: vim.api.keyset.highlight
---@field style? vim.api.keyset.highlight

---@alias monoglow.Highlights table<string,monoglow.Highlight|string>

---@alias monoglow.HighlightsFn fun(colors: ColorScheme, opts:monoglow.Config):monoglow.Highlights
