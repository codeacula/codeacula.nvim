-- neotest defines its groups with `hi default` (hard-coded hex) at load and again
-- on ColorScheme, so groups set here win. NeotestFocused (bold underline) has no
-- colour and is left to its default.
local M = {}

M.source = "neotest"

function M.get(c)
  return {
    NeotestPassed = { fg = c.success_base },
    NeotestFailed = { fg = c.error },
    NeotestRunning = { fg = c.warning },
    NeotestSkipped = { fg = c.fg_dim },
    NeotestWatching = { fg = c.info },
    -- default links to Normal would also carry Normal's bg into the tree
    NeotestTest = { fg = c.fg },
    NeotestUnknown = { fg = c.fg_dim },

    NeotestNamespace = { fg = c.keyword },
    NeotestDir = { fg = c.type },
    NeotestFile = { fg = c.fg_bright },
    NeotestAdapterName = { fg = c.fg_bright, bold = true },
    NeotestIndent = { fg = c.border },
    NeotestExpandMarker = { fg = c.fg_dim },
    NeotestMarked = { fg = c.special, bold = true },
    -- the single position the summary is narrowed to
    NeotestTarget = { fg = c.accent },
    -- window picker: replaces StatusLine/StatusLineNC in every candidate window at
    -- once, so not gold, and it needs a bg to keep the bar filled
    NeotestWinSelect = { fg = c.fg_bright, bg = c.bg_highlight, bold = true },
    -- named in config but never defined by neotest
    NeotestBorder = { link = "FloatBorder" },
  }
end

return M
