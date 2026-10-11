local M = {}

M.source = "harpoon"

-- harpoon reads HarpoonCurrentFile for the current file in its menu but never defines it
function M.get(c)
  return {
    HarpoonCurrentFile = { fg = c.accent, bold = true },
  }
end

return M
