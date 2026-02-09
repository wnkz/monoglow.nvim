local M = {}

M.url = "https://github.com/OXY2DEV/markview.nvim"

---@type monoglow.HighlightsFn
function M.get(c, opts)
  return {
    MarkviewBlockQuoteDefault = {},
    MarkviewBlockQuoteError = {},
    MarkviewBlockQuoteNote = {},
    MarkviewBlockQuoteOk = {},
    MarkviewBlockQuoteSpecial = { fg = c.lack },
    MarkviewBlockQuoteWarn = {},

    MarkviewHeading1 = { fg = c.gray8, bg = c.gray3, bold = true },
    MarkviewHeading1Sign = { fg = c.gray8 },
    MarkviewHeading2 = { fg = c.gray7, bg = c.gray3, bold = true },
    MarkviewHeading2Sign = { fg = c.gray7 },
    MarkviewHeading3 = { fg = c.gray6, bg = c.gray3 },
    MarkviewHeading3Sign = { fg = c.gray6 },
    MarkviewHeading4 = { fg = c.gray6, bg = c.gray3, italic = true },
    MarkviewHeading4Sign = { fg = c.gray6 },
    MarkviewHeading5 = { fg = c.gray6, bg = c.gray3, italic = true },
    MarkviewHeading5Sign = { fg = c.gray6 },
    MarkviewHeading6 = { fg = c.gray6, bg = c.gray3, italic = true },
    MarkviewHeading6Sign = { fg = c.gray6 },

    MarkviewListItemStar = { fg = c.gray6 },
    MarkviewListItemPlus = { fg = c.gray5 },
    MarkviewListItemMinus = { fg = c.gray7 },
  }
end

return M
