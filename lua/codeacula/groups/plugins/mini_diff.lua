-- Intentionally empty. mini.diff sets every group with `default = true` and
-- re-applies on ColorScheme, linking to core groups that already express the
-- intent: MiniDiffSign* -> Added/Changed/Removed (git_add/change/delete) and
-- MiniDiffOver* -> DiffAdd/DiffText/DiffChange/DiffDelete. Overriding would only
-- duplicate base.lua.
local M = {}

M.source = "mini.diff"

function M.get()
  return {}
end

return M
