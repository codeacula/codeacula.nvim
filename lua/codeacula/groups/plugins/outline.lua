local M = {}

M.source = "outline.nvim"

-- Symbol icon colours come from outline's `symbols.icons[kind].hl` config,
-- which points at core groups (Type, Function, Identifier, ...), not Outline* groups.
function M.get(c)
  return {
    -- marks the hovered symbol and all its parents, so not gold
    OutlineCurrent = { fg = c.fg_bright, bg = c.bg_highlight, bold = true },
    -- outline snapshots these from Comment/Normal once at setup; set them so they track the theme
    OutlineGuides = { fg = c.comment },
    OutlineFoldMarker = { fg = c.fg_dim },

    -- outline's own links (not default=true) are set once at setup, so `hi clear`
    -- on a colorscheme reload wipes them; restate them here
    OutlineDetails = { link = "Comment" },
    OutlineLineno = { link = "LineNr" },
    OutlineJumpHighlight = { link = "Visual" },
    OutlineHelpTip = { link = "Comment" },
    OutlineStatusFt = { link = "Type" },
    OutlineStatusProvider = { link = "Special" },
    OutlineStatusError = { link = "ErrorMsg" },
    OutlineKeymapHelpKey = { link = "Special" },
    OutlineKeymapHelpDisabled = { link = "Comment" },
  }
end

return M
