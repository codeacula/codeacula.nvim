local M = {}

M.source = "snacks.nvim"

-- Snacks.util.set_hl builds names as prefix .. key, so some groups never
-- appear literally; prefixes are kept as narrow as the source allows.
M.dynamic = {
  "SnacksNotifier",
  "SnacksDiff",
  "SnacksDashboard",
  "SnacksPickerGitStatus",
  "SnacksPickerIcon",
}

-- Every snacks group is set with default = true (and re-applied that way on
-- ColorScheme), so anything set here wins. Groups whose default link already
-- reads right under codeacula (picker borders/titles via Float*, indent scope,
-- words via LspReference*, zen, terminal) are left to snacks.
function M.get(c)
  local float = c.bg_float

  local hl = {
    -- picker
    SnacksPickerMatch = { fg = c.match, bold = true },
    SnacksPickerFile = { fg = c.fg_bright },
    SnacksPickerDir = { fg = c.fg_dim },
    SnacksPickerTotals = { fg = c.fg_dim },
    -- NonText (navy_600) is unreadable on the float background
    SnacksPickerPathHidden = { fg = c.comment },
    SnacksPickerPathIgnored = { fg = c.comment },
    SnacksPickerBufFlags = { fg = c.comment },
    SnacksPickerKeymapRhs = { fg = c.comment },
    -- LineNr (navy_500) is under the dim-tier floor on the float
    SnacksPickerCol = { fg = c.comment },
    -- links to Normal, whose editor bg would box the icon inside the float
    SnacksPickerIconFile = { fg = c.fg },
    -- LSP symbol kinds whose default link misses the kind table
    SnacksPickerIconEvent = { fg = c.type },
    SnacksPickerIconOperator = { fg = c.special },
    SnacksPickerIconVariable = { fg = c.fg_bright },
    -- bg only: a CursorLine fg takes priority over extmarks and would hide the
    -- gold match characters on the selected row
    SnacksPickerListCursorLine = { bg = c.bg_highlight },
    SnacksPickerPreviewCursorLine = { bg = c.bg_highlight },
    SnacksPickerGitStatusModified = { fg = c.git_change },
    SnacksPickerGitStatusUntracked = { fg = c.comment },
    SnacksPickerGitStatusIgnored = { fg = c.comment },
    SnacksPickerGitBranchCurrent = { fg = c.accent },

    -- computed once from DiffAdd etc. when snacks loads, so they go stale
    SnacksDiffAddLineNr = { fg = c.git_add, bg = c.success_bg },
    SnacksDiffDeleteLineNr = { fg = c.git_delete, bg = c.danger_bg },
    SnacksDiffContextLineNr = { fg = c.git_change, bg = c.info_bg },
    SnacksDiffConflictLineNr = { fg = c.warning, bg = c.warning_bg },

    -- input: defaults use Normal and a DiagnosticInfo border
    SnacksInputNormal = { link = "NormalFloat" },
    SnacksInputBorder = { link = "FloatBorder" },
    SnacksInputTitle = { link = "FloatTitle" },

    -- notifier history window defaults to Normal
    SnacksNotifierHistory = { link = "NormalFloat" },

    -- dashboard
    SnacksDashboardDesc = { fg = c.fg },
    SnacksDashboardFile = { fg = c.fg_bright },
    SnacksDashboardDir = { fg = c.comment },
    SnacksDashboardFooter = { fg = c.fg_dim },
  }

  -- notifier: message windows default to Normal (editor bg); keep the
  -- per-level border/title colour but put everything on the float surface
  local levels = {
    Trace = c.comment,
    Debug = c.comment,
    Info = c.info,
    Warn = c.warning,
    Error = c.error,
  }
  for level, color in pairs(levels) do
    hl["SnacksNotifier" .. level] = { fg = c.fg, bg = float }
    hl["SnacksNotifierIcon" .. level] = { fg = color, bg = float }
    hl["SnacksNotifierBorder" .. level] = { fg = color, bg = float }
    hl["SnacksNotifierTitle" .. level] = { fg = color, bg = float, bold = true }
    hl["SnacksNotifierFooter" .. level] = { fg = color, bg = float }
  end

  return hl
end

return M
