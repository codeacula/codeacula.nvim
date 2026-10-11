local M = {}

M.source = "inc-rename.nvim"

-- inc-rename defines no highlight groups. The preview uses its `hl_group`
-- option (default "Substitute", a core group) plus Comment and Cursor.
-- The command-line popup is themed by noice.lua (NoiceCmdline*IncRename).
function M.get()
  return {}
end

return M
