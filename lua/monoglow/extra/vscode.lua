local util = require("monoglow.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  local vscode = util.template(
    [[
{
  "name": "${_style_name}",
  "type": "dark",
  "colors": {
    "activityBar.background": "${bg}",
    "activityBar.foreground": "${fg}",
    "activityBarBadge.background": "${glow}",
    "activityBarBadge.foreground": "${bg}",
    "button.background": "${glow}",
    "button.foreground": "${bg}",
    "button.hoverBackground": "${glow}",
    "diffEditor.insertedTextBackground": "${diff.add}22",
    "diffEditor.removedTextBackground": "${diff.delete}22",
    "dropdown.background": "${bg_popup}",
    "dropdown.border": "${border}",
    "editor.background": "${bg}",
    "editor.findMatchBackground": "${visual}",
    "editor.findMatchHighlightBackground": "${visual}55",
    "editor.foreground": "${fg}",
    "editor.lineHighlightBackground": "${cur_line}",
    "editor.selectionBackground": "${visual}",
    "editor.selectionHighlightBackground": "${visual}55",
    "editor.wordHighlightBackground": "${visual}55",
    "editor.wordHighlightStrongBackground": "${visual}55",
    "editorBracketMatch.background": "${visual}",
    "editorBracketMatch.border": "${visual}",
    "editorCursor.foreground": "${fg}",
    "editorError.foreground": "${error}",
    "editorGroup.border": "${border}",
    "editorGroupHeader.tabsBackground": "${bg}",
    "editorGutter.addedBackground": "${git.add}",
    "editorGutter.deletedBackground": "${git.delete}",
    "editorGutter.modifiedBackground": "${git.change}",
    "editorHoverWidget.background": "${bg_popup}",
    "editorHoverWidget.border": "${border}",
    "editorIndentGuide.activeBackground": "${gray4}",
    "editorIndentGuide.background": "${gray3}",
    "editorLineNumber.activeForeground": "${cur_line_nr}",
    "editorLineNumber.foreground": "${gray4}",
    "editorLink.activeForeground": "${glow}",
    "editorOverviewRuler.addedForeground": "${git.add}",
    "editorOverviewRuler.border": "${border}",
    "editorOverviewRuler.deletedForeground": "${git.delete}",
    "editorOverviewRuler.errorForeground": "${error}",
    "editorOverviewRuler.modifiedForeground": "${git.change}",
    "editorOverviewRuler.warningForeground": "${warning}",
    "editorRuler.foreground": "${gray3}",
    "editorSuggestWidget.background": "${bg_popup}",
    "editorSuggestWidget.border": "${border}",
    "editorSuggestWidget.foreground": "${fg}",
    "editorSuggestWidget.highlightForeground": "${glow}",
    "editorSuggestWidget.selectedBackground": "${visual}",
    "editorWarning.foreground": "${warning}",
    "editorWhitespace.foreground": "${special.whitespace}",
    "editorWidget.background": "${bg_popup}",
    "editorWidget.border": "${border}",
    "focusBorder": "${glow}",
    "input.background": "${bg}",
    "input.border": "${border}",
    "input.foreground": "${fg}",
    "input.placeholderForeground": "${gray4}",
    "list.activeSelectionBackground": "${visual}",
    "list.activeSelectionForeground": "${fg}",
    "list.focusBackground": "${visual}",
    "list.focusForeground": "${fg}",
    "list.highlightForeground": "${glow}",
    "list.hoverBackground": "${cur_line}",
    "list.hoverForeground": "${fg}",
    "list.inactiveSelectionBackground": "${visual}",
    "list.inactiveSelectionForeground": "${fg}",
    "menu.background": "${bg_menu}",
    "menu.foreground": "${fg}",
    "menu.selectionBackground": "${visual}",
    "menu.selectionForeground": "${fg}",
    "menu.separatorBackground": "${border}",
    "menubar.selectionBackground": "${visual}",
    "menubar.selectionForeground": "${fg}",
    "notificationCenterHeader.background": "${bg_popup}",
    "notifications.background": "${bg_popup}",
    "notifications.border": "${border}",
    "notifications.foreground": "${fg}",
    "panel.background": "${bg}",
    "panel.border": "${border}",
    "panelTitle.activeBorder": "${glow}",
    "panelTitle.activeForeground": "${fg}",
    "panelTitle.inactiveForeground": "${gray5}",
    "peekView.border": "${glow}",
    "peekViewEditor.background": "${bg_popup}",
    "peekViewEditor.matchHighlightBackground": "${visual}",
    "peekViewResult.background": "${bg_popup}",
    "peekViewResult.matchHighlightBackground": "${visual}",
    "peekViewResult.selectionBackground": "${visual}",
    "pickerGroup.border": "${border}",
    "pickerGroup.foreground": "${glow}",
    "progressBar.background": "${glow}",
    "quickInput.background": "${bg_popup}",
    "quickInput.foreground": "${fg}",
    "scrollbar.shadow": "${bg}",
    "scrollbarSlider.activeBackground": "${gray5}50",
    "scrollbarSlider.background": "${gray5}20",
    "scrollbarSlider.hoverBackground": "${gray5}30",
    "selection.background": "${visual}",
    "sideBar.background": "${bg}",
    "sideBar.border": "${border}",
    "sideBar.foreground": "${fg_sidebar}",
    "sideBarSectionHeader.background": "${bg}",
    "sideBarSectionHeader.foreground": "${fg}",
    "sideBarTitle.foreground": "${fg}",
    "statusBar.background": "${bg_statusline}",
    "statusBar.border": "${border}",
    "statusBar.debuggingBackground": "${bg_statusline}",
    "statusBar.debuggingForeground": "${fg}",
    "statusBar.foreground": "${fg}",
    "statusBar.noFolderBackground": "${bg_statusline}",
    "statusBar.noFolderForeground": "${fg}",
    "statusBarItem.activeBackground": "${visual}",
    "statusBarItem.hoverBackground": "${visual}",
    "statusBarItem.prominentBackground": "${bg_statusline}",
    "statusBarItem.prominentHoverBackground": "${visual}",
    "statusBarItem.remoteBackground": "${glow}",
    "statusBarItem.remoteForeground": "${bg}",
    "tab.activeBackground": "${bg}",
    "tab.activeBorder": "${glow}",
    "tab.activeForeground": "${fg}",
    "tab.border": "${border}",
    "tab.inactiveBackground": "${bg}",
    "tab.inactiveForeground": "${gray5}",
    "tab.lastPinnedBorder": "${border}",
    "tab.unfocusedActiveBorder": "${gray5}",
    "tab.unfocusedActiveForeground": "${gray5}",
    "tab.unfocusedInactiveForeground": "${gray5}",
    "terminal.ansiBlack": "${terminal.black}",
    "terminal.ansiBlue": "${terminal.blue}",
    "terminal.ansiBrightBlack": "${terminal.black_bright}",
    "terminal.ansiBrightBlue": "${terminal.blue_bright}",
    "terminal.ansiBrightCyan": "${terminal.cyan_bright}",
    "terminal.ansiBrightGreen": "${terminal.green_bright}",
    "terminal.ansiBrightMagenta": "${terminal.magenta_bright}",
    "terminal.ansiBrightRed": "${terminal.red_bright}",
    "terminal.ansiBrightWhite": "${terminal.white_bright}",
    "terminal.ansiBrightYellow": "${terminal.yellow_bright}",
    "terminal.ansiCyan": "${terminal.cyan}",
    "terminal.ansiGreen": "${terminal.green}",
    "terminal.ansiMagenta": "${terminal.magenta}",
    "terminal.ansiRed": "${terminal.red}",
    "terminal.ansiWhite": "${terminal.white}",
    "terminal.ansiYellow": "${terminal.yellow}",
    "terminal.background": "${bg}",
    "terminal.foreground": "${fg}",
    "textLink.activeForeground": "${glow}",
    "textLink.foreground": "${glow}",
    "titleBar.activeBackground": "${bg}",
    "titleBar.activeForeground": "${fg}",
    "titleBar.border": "${border}",
    "titleBar.inactiveBackground": "${bg}",
    "titleBar.inactiveForeground": "${gray5}",
    "walkThrough.embeddedEditorBackground": "${bg}",
    "widget.shadow": "${bg}",
    "editorBracketHighlight.foreground1": "${syntax.punctuation}",
    "editorBracketHighlight.foreground2": "${syntax.punctuation}",
    "editorBracketHighlight.foreground3": "${syntax.punctuation}",
    "editorBracketHighlight.foreground4": "${syntax.punctuation}",
    "editorBracketHighlight.foreground5": "${syntax.punctuation}",
    "editorBracketHighlight.foreground6": "${syntax.punctuation}"
  },
  "tokenColors": [
    {
      "scope": [
        "comment",
        "punctuation.definition.comment",
        "string.comment"
      ],
      "settings": {
        "foreground": "${syntax.comment}",
        "fontStyle": "italic"
      }
    },
    {
      "scope": [
        "constant.numeric",
        "constant.language.boolean",
        "constant.language.null",
        "constant.language.undefined"
      ],
      "settings": {
        "foreground": "${syntax.const}"
      }
    },
    {
      "scope": [
        "constant.language",
        "support.constant",
        "variable.language.this",
        "variable.language.super"
      ],
      "settings": {
        "foreground": "${syntax.const_builtin}"
      }
    },
    {
      "scope": [
        "constant.character",
        "constant.other"
      ],
      "settings": {
        "foreground": "${syntax.const}"
      }
    },
    {
      "scope": [
        "variable.other.constant"
      ],
      "settings": {
        "foreground": "${syntax.const}"
      }
    },
    {
      "scope": [
        "string",
        "string.quoted",
        "string.template"
      ],
      "settings": {
        "foreground": "${syntax.string}"
      }
    },
    {
      "scope": [
        "string.regexp",
        "constant.character.escape",
        "constant.other.placeholder"
      ],
      "settings": {
        "foreground": "${syntax.string_escape}"
      }
    },
    {
      "scope": [
        "keyword.control",
        "keyword.other",
        "storage.type",
        "storage.modifier"
      ],
      "settings": {
        "foreground": "${syntax.keyword}"
      }
    },
    {
      "scope": [
        "keyword.control.return",
        "keyword.control.flow.return"
      ],
      "settings": {
        "foreground": "${syntax.keyword_return}"
      }
    },
    {
      "scope": [
        "keyword.control.exception",
        "keyword.control.trycatch"
      ],
      "settings": {
        "foreground": "${syntax.keyword_exception}"
      }
    },
    {
      "scope": [
        "punctuation.definition.parameters",
        "punctuation.definition.arguments",
        "punctuation.definition.array",
        "punctuation.definition.bracket",
        "punctuation.section.brackets",
        "punctuation.section.parens",
        "punctuation.parenthesis",
        "punctuation.brackets",
        "meta.brace.round",
        "meta.brace.square"
      ],
      "settings": {
        "foreground": "${syntax.punctuation}"
      }
    },
    {
      "scope": [
        "keyword.operator",
        "keyword.operator.comparison",
        "keyword.operator.arithmetic",
        "keyword.operator.logical",
        "keyword.operator.assignment",
        "keyword.operator.bitwise",
        "punctuation.separator.pointer-access"
      ],
      "settings": {
        "foreground": "${glow}"
      }
    },
    {
      "scope": [
        "entity.name.function",
        "support.function"
      ],
      "settings": {
        "foreground": "${syntax.func_def}"
      }
    },
    {
      "scope": [
        "meta.function-call",
        "meta.function-call.generic",
        "support.function.builtin"
      ],
      "settings": {
        "foreground": "${syntax.func_call}"
      }
    },
    {
      "scope": [
        "variable.parameter",
        "meta.parameters",
        "meta.function.parameters"
      ],
      "settings": {
        "foreground": "${syntax.func_param}"
      }
    },
    {
      "scope": [
        "entity.name.type",
        "entity.name.class",
        "support.type",
        "support.class"
      ],
      "settings": {
        "foreground": "${syntax.type}"
      }
    },
    {
      "scope": [
        "entity.name.type.primitive",
        "storage.type.primitive",
        "storage.type.built-in",
        "storage.type.numeric",
        "support.type.primitive"
      ],
      "settings": {
        "foreground": "${syntax.type_primitive}"
      }
    },
    {
      "scope": [
        "entity.other.inherited-class",
        "storage.type.class"
      ],
      "settings": {
        "foreground": "${syntax.type_def}"
      }
    },
    {
      "scope": [
        "variable",
        "variable.other",
        "variable.language"
      ],
      "settings": {
        "foreground": "${syntax.var}"
      }
    },
    {
      "scope": [
        "variable.other.property",
        "variable.other.member",
        "support.variable.property",
        "meta.object-literal.key"
      ],
      "settings": {
        "foreground": "${syntax.property}"
      }
    },
    {
      "scope": [
        "entity.name.tag",
        "support.class.component"
      ],
      "settings": {
        "foreground": "${syntax.tag}"
      }
    },
    {
      "scope": [
        "entity.other.attribute-name"
      ],
      "settings": {
        "foreground": "${syntax.property}"
      }
    },
    {
      "scope": [
        "punctuation.definition.tag",
        "punctuation.separator",
        "punctuation.terminator",
        "punctuation.section"
      ],
      "settings": {
        "foreground": "${syntax.punctuation}"
      }
    },
    {
      "scope": [
        "punctuation.definition.string",
        "punctuation.definition.parameters",
        "punctuation.definition.array",
        "punctuation.definition.bracket",
        "meta.brace"
      ],
      "settings": {
        "foreground": "${syntax.punctuation}"
      }
    },
    {
      "scope": [
        "markup.heading"
      ],
      "settings": {
        "foreground": "${title}",
        "fontStyle": "bold"
      }
    },
    {
      "scope": [
        "markup.bold"
      ],
      "settings": {
        "fontStyle": "bold"
      }
    },
    {
      "scope": [
        "markup.italic"
      ],
      "settings": {
        "fontStyle": "italic"
      }
    },
    {
      "scope": [
        "markup.strikethrough"
      ],
      "settings": {
        "fontStyle": "strikethrough"
      }
    },
    {
      "scope": [
        "markup.underline"
      ],
      "settings": {
        "fontStyle": "underline"
      }
    },
    {
      "scope": [
        "markup.quote"
      ],
      "settings": {
        "foreground": "${syntax.comment}",
        "fontStyle": "italic"
      }
    },
    {
      "scope": [
        "markup.inline.raw",
        "markup.fenced_code.block"
      ],
      "settings": {
        "foreground": "${syntax.string}"
      }
    },
    {
      "scope": [
        "markup.list"
      ],
      "settings": {
        "foreground": "${glow}"
      }
    }
  ]
}
]],
    colors
  )
  return vscode
end

return M
