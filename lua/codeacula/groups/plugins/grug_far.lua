-- grug-far sets its groups with `default = true` once in setup (not on
-- ColorScheme), so groups set here win. Help, input, line-number and diff-line
-- groups keep their core links.
local M = {}

M.source = "grug-far.nvim"

function M.get(c)
  return {
    -- defaults are hard-coded hex
    GrugFarResultsAddIndicator = { fg = c.git_add },
    GrugFarResultsChangeIndicator = { fg = c.git_change },
    GrugFarResultsRemoveIndicator = { fg = c.git_delete },

    -- default DiffText would read as a diff hunk rather than a search hit
    GrugFarResultsMatch = { link = "Search" },
    GrugFarCurrentMatch = { link = "CurSearch" },

    -- default Underlined leaves file names uncoloured
    GrugFarResultsPath = { fg = c.fg_bright, bold = true },
    GrugFarResultsStats = { fg = c.fg_dim },
    GrugFarResultsNumberLabel = { fg = c.fg_dim },
    GrugFarResultsCmdHeader = { fg = c.fg_dim },

    -- default Identifier is plain body text, so keys would not stand out
    GrugFarHelpHeaderKey = { link = "Special" },
    GrugFarHelpWinActionKey = { link = "Special" },
  }
end

return M
