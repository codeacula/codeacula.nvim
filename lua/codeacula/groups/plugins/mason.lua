local M = {}

M.source = "mason.nvim"

-- Secondary variants appear while the help view is open.
function M.get(c)
  return {
    MasonHeader = { fg = c.fg_bright, bg = c.bg_highlight, bold = true },
    MasonHeaderSecondary = { fg = c.fg_bright, bg = c.arcane_600, bold = true },
    MasonHeading = { fg = c.fg_bright, bold = true },

    MasonHighlight = { fg = c.special },
    MasonHighlightBlock = { fg = c.bg, bg = c.special },
    MasonHighlightSecondary = { fg = c.keyword },
    MasonHighlightBlockSecondary = { fg = c.bg, bg = c.keyword },
    -- *BlockBold* is only used for the active tab
    MasonHighlightBlockBold = { fg = c.bg, bg = c.accent, bold = true },
    MasonHighlightBlockBoldSecondary = { fg = c.bg, bg = c.accent, bold = true },

    MasonMuted = { fg = c.fg_dim },
    MasonMutedBlock = { fg = c.fg, bg = c.bg_highlight },
    MasonMutedBlockBold = { fg = c.fg, bg = c.bg_highlight, bold = true },
  }
end

return M
