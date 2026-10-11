local M = {}

M.source = "yanky.nvim"

-- Both default to Search, which makes a yank/put flash look like a search hit.
-- One step stronger than Visual so the flash still reads after leaving a selection.
function M.get(c)
  return {
    YankyYanked = { bg = c.arcane_600 },
    YankyPut = { bg = c.arcane_600 },
  }
end

return M
