local util = require("monoglow.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  -- OpenCode uses "error" color for built-in syntax highlighting (variable.builtin,
  -- function.builtin, etc.) as well as actual errors. We use luster (a subtle light
  -- teal-ish white) to maintain the monochrome aesthetic while providing distinction.
  local c = vim.tbl_extend("force", colors, {
    error_muted = colors.luster,
  })

  local opencode = util.template(
    [[
{
  "$schema": "https://opencode.ai/theme.json",
  "defs": {
    "bg": "${bg}",
    "fg": "${fg}",
    "glow": "${glow}",
    "blue2": "${blue2}",
    "luster": "${luster}",
    "gray3": "${gray3}",
    "gray4": "${gray4}",
    "gray5": "${gray5}",
    "gray6": "${gray6}",
    "gray7": "${gray7}",
    "gray9": "${gray9}",
    "border": "${border}",
    "bgPanel": "${bg_popup}",
    "bgElement": "${cur_line}",
    "error": "${error_muted}",
    "warning": "${warning}",
    "success": "${ok}",
    "info": "${info}",
    "title": "${title}",
    "gitAdd": "${git.add}",
    "gitDelete": "${git.delete}",
    "diffAdd": "${diff.add}",
    "diffDelete": "${diff.delete}",
    "comment": "${syntax.comment}",
    "keyword": "${syntax.keyword}",
    "funcDef": "${syntax.func_def}",
    "var": "${syntax.var}",
    "string": "${syntax.string}",
    "const": "${syntax.const}",
    "type": "${syntax.type}",
    "punctuation": "${syntax.punctuation}"
  },
  "theme": {
    "primary": "glow",
    "secondary": "blue2",
    "accent": "glow",
    "text": "fg",
    "textMuted": "gray5",
    "background": "bg",
    "backgroundPanel": "bgPanel",
    "backgroundElement": "bgElement",
    "border": "border",
    "borderActive": "glow",
    "borderSubtle": "gray3",
    "error": "error",
    "warning": "warning",
    "success": "success",
    "info": "info",
    "diffAdded": "gitAdd",
    "diffRemoved": "gitDelete",
    "diffContext": "fg",
    "diffHunkHeader": "gray6",
    "diffHighlightAdded": "glow",
    "diffHighlightRemoved": "luster",
    "diffAddedBg": "diffAdd",
    "diffRemovedBg": "diffDelete",
    "diffContextBg": "bg",
    "diffLineNumber": "gray5",
    "diffAddedLineNumberBg": "diffAdd",
    "diffRemovedLineNumberBg": "diffDelete",
    "markdownText": "fg",
    "markdownHeading": "title",
    "markdownLink": "glow",
    "markdownLinkText": "gray7",
    "markdownCode": "string",
    "markdownBlockQuote": "comment",
    "markdownEmph": "fg",
    "markdownStrong": "gray9",
    "markdownHorizontalRule": "gray4",
    "markdownListItem": "glow",
    "markdownListEnumeration": "glow",
    "markdownImage": "glow",
    "markdownImageText": "gray7",
    "markdownCodeBlock": "string",
    "syntaxComment": "comment",
    "syntaxKeyword": "keyword",
    "syntaxFunction": "funcDef",
    "syntaxVariable": "var",
    "syntaxString": "string",
    "syntaxNumber": "const",
    "syntaxType": "type",
    "syntaxOperator": "glow",
    "syntaxPunctuation": "punctuation"
  }
}
]],
    c
  )
  return opencode
end

return M
