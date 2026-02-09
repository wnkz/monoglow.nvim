local M = {}

M.url = "https://github.com/nvimdev/dashboard-nvim"

---@type monoglow.HighlightsFn
function M.get(c, opts)
  return {
    -- General
    DashboardHeader = { fg = c.fg },
    DashboardFooter = { fg = c.gray4 },
    -- Hyper theme
    DashboardProjectTitle = { fg = c.title },
    DashboardProjectTitleIcon = { fg = c.title },
    DashboardProjectIcon = { fg = c.title },
    DashboardMruTitle = { fg = c.title },
    DashboardMruTitleIcon = { fg = c.title },
    DashboardMruIcon = { fg = c.title },
    DashboardFiles = { fg = c.fg },
    DashboardShortCutIcon = { fg = c.glow },
    -- Doom theme
    DashboardDesc = { fg = c.fg },
    DashboardKey = { fg = c.glow },
    DashboardIcon = { fg = c.icon, bold = true },
    DashboardShortCut = { fg = c.gray10 },
  }
end

return M
