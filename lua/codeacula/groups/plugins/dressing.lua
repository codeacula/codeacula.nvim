local M = {}

M.source = "dressing.nvim"

function M.get()
  return {
    -- dressing sets this once, unconditionally, when it loads and never on
    -- ColorScheme; repeat its link so the index survives `:hi clear` on reload
    DressingSelectIdx = { link = "Special" },
  }
end

return M
