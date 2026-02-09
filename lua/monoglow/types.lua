---@class monoglow.Highlight: vim.api.keyset.highlight
---@field style? vim.api.keyset.highlight

---@alias monoglow.Highlights table<string,monoglow.Highlight|string>

---@alias monoglow.HighlightsFn fun(colors: ColorScheme, opts:monoglow.Config):monoglow.Highlights

---@class GitColors
---@field add string
---@field change string
---@field delete string

---@class DiffColors
---@field add string
---@field delete string
---@field change string
---@field text string

---@class SpecialColors
---@field comment string
---@field exception string
---@field keyword string
---@field param string
---@field property string
---@field whitespace string

---@class SyntaxColors
---@field boolean string
---@field builtin string
---@field comment string
---@field const string
---@field const_builtin string
---@field func_call string
---@field func_def string
---@field func_param string
---@field keyword string
---@field keyword_exception string
---@field keyword_return string
---@field property string
---@field punctuation string
---@field special string
---@field string string
---@field string_escape string
---@field tag string
---@field type string
---@field type_def string
---@field type_primitive string
---@field var string
---@field var_builtin string
---@field var_member string

---@class FsColors
---@field dir string
---@field file string
---@field exec string
---@field link string
---@field binary_data string
---@field socket string

---@class CmpColors
---@field kind string
---@field snippet string
---@field deprecated string
