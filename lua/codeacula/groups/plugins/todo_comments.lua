-- todo-comments builds TodoBg/TodoFg/TodoSign<KEYWORD> for each base keyword
-- with `hi def` (re-run on ColorScheme), so groups set here win. Alt keywords
-- (FIXME, BUG, WARNING, INFO, ...) reuse their base keyword's groups.
-- Bg = the keyword capsule, Fg = text after the keyword, Sign = gutter icon.
local M = {}

M.source = "todo-comments.nvim"
-- names are "TodoBg" .. kw etc., built from the keywords table at runtime
M.dynamic = { "TodoBg", "TodoFg", "TodoSign" }

local kinds = {
  FIX = { capsule = "@comment.error", fg = "DiagnosticError" },
  TODO = { capsule = "@comment.todo", fg = "DiagnosticInfo" },
  HACK = { capsule = "@comment.warning", fg = "DiagnosticWarn" },
  WARN = { capsule = "@comment.warning", fg = "DiagnosticWarn" },
  PERF = { capsule = "@comment.warning", fg = "DiagnosticWarn" },
  NOTE = { capsule = "@comment.note", fg = "DiagnosticHint" },
  TEST = { capsule = "@comment.note", fg = "DiagnosticHint" },
}

function M.get()
  local hl = {}
  for kw, kind in pairs(kinds) do
    -- the @comment.* captures already are the alert *_bg/*_fg bold capsules
    hl["TodoBg" .. kw] = { link = kind.capsule }
    hl["TodoFg" .. kw] = { link = kind.fg }
    -- no bg, so the sign sits on SignColumn/CursorLineSign like other signs
    hl["TodoSign" .. kw] = { link = kind.fg }
  end
  return hl
end

return M
