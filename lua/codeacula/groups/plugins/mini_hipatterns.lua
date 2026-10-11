-- The default is Diagnostic* reversed; use the comment-tag capsule instead
-- (alert *_bg fill, alert *_fg text, bold) so these match todo-comments.
-- MiniHipatterns_<hex> colour-swatch groups are computed at runtime and left alone.
local M = {}

M.source = "mini.hipatterns"

function M.get(c)
  return {
    MiniHipatternsFixme = { fg = c.danger_fg, bg = c.danger_bg, bold = true },
    MiniHipatternsHack = { fg = c.warning_fg, bg = c.warning_bg, bold = true },
    MiniHipatternsTodo = { fg = c.info_fg, bg = c.info_bg, bold = true },
    MiniHipatternsNote = { fg = c.note_fg, bg = c.note_bg, bold = true },
  }
end

return M
