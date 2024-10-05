local M = {}

M.url = "https://github.com/nvimdev/dashboard-nvim"

function M.get(c, opts)
  return {
    -- General
    DashboardHeader = { fg = c.gray1 },
    DashboardFooter = { fg = c.gray1 },
    -- Hyper theme
    DashboardProjectTitle = { fg = c.gray2 },
    DashboardProjectTitleIcon = { fg = c.gray2 },
    DashboardProjectIcon = { fg = c.gray3 },
    DashboardMruTitle = { fg = c.gray3 },
    DashboardMruIcon = { fg = c.gray2 },
    DashboardFiles = { fg = c.blue1 },
    DashboardShortCutIcon = { fg = c.glow },
    -- Doom theme
    DashboardDesc = { fg = c.fg },
    DashboardKey = { fg = c.glow },
    DashboardIcon = { fg = c.gray2, bold = true },
    DashboardShortCut = { fg = c.gray2 },
  }
end

return M
