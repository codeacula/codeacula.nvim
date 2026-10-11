-- gitsigns derives every group with `default = true` on ColorScheme and skips
-- groups already set. Signs, numbers, line and preview groups fall through to
-- Added/Changed/Removed and Diff*, which base defines; staged variants are
-- derived from those. Only defaults that look wrong are overridden here.
local util = require("codeacula.util")

local M = {}

M.source = "gitsigns.nvim"

function M.get(c)
  -- word-diff regions sit on a DiffAdd/DiffDelete line, so they need a stronger
  -- tint than the line fill; the default link is TermCursor (a gold block)
  local add_word = util.blend(c.git_add, c.bg, 0.30)
  local delete_word = util.blend(c.git_delete, c.bg, 0.30)

  return {
    GitSignsAddInline = { bg = add_word },
    GitSignsChangeInline = { bg = c.diff_text },
    GitSignsDeleteInline = { bg = delete_word },

    -- default NonText (navy_600) is nearly invisible on navy_950
    GitSignsCurrentLineBlame = { fg = c.comment, italic = true },
    -- default Constant would paint this meta text keyword purple
    GitSignsNoEOLPreview = { fg = c.fg_dim, italic = true },
  }
end

return M
