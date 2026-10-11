-- smear-cursor takes its colour from the `cursor_color` option, not from a group
-- of its own. Unset, it reads Cursor's bg (already c.cursor); a group name
-- resolves to that group's bg; "none" samples the text colour under the cursor.
-- It writes its SmearCursor<level> gradient groups unconditionally with
-- nvim_set_hl and rebuilds them after ColorScheme, so presetting them is futile.
--
-- LazyVim's smear-cursor extra sets `cursor_color = "none"`, so the smear does
-- not match Cursor. To make it gold, override in the user's LazyVim spec:
--   { "sphamba/smear-cursor.nvim", opts = { cursor_color = "Cursor" } }
local M = {}

M.source = "smear-cursor.nvim"

function M.get()
  return {}
end

return M
