-- treesitter-context sets its groups once with `default = true`. The context
-- window (TreesitterContext -> NormalFloat) and separator (-> FloatBorder)
-- defaults are right; TreesitterContextLineNumberBottom links to
-- TreesitterContextBottom, so it picks up the underline set here.
local M = {}

M.source = "nvim-treesitter-context"

function M.get(c)
  return {
    -- the gutter window maps NormalFloat to this group; LineNr has no bg, so the
    -- default leaves the numbers on navy_950 beside a navy_900 context strip
    TreesitterContextLineNumber = { fg = c.line_nr, bg = c.bg_float },
    -- default NONE; the context strip shares cursorline's navy_900, so mark its edge
    TreesitterContextBottom = { underline = true, sp = c.border },
  }
end

return M
