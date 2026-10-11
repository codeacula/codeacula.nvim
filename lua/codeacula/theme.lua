local util = require("codeacula.util")

local M = {}

---Resolve brand tokens into the table every group module reads:
---all palette tokens plus semantic roles.
function M.resolve(p)
  local c = vim.deepcopy(p)

  -- surfaces
  c.bg = p.navy_950
  c.bg_float = p.navy_900
  c.bg_sidebar = p.navy_900
  c.bg_statusline = p.navy_900
  c.cursorline = p.navy_900
  c.bg_highlight = p.navy_700
  c.border = p.navy_700
  c.bg_visual = p.arcane_700

  -- text
  c.fg = p.silver_400
  c.fg_bright = p.silver_300
  c.fg_dim = p.silver_500
  c.comment = p.silver_600
  c.doc_comment = p.silver_500
  c.line_nr = p.navy_500
  c.line_nr_active = p.silver_300

  -- syntax
  c.keyword = p.arcane_200
  c.label = p.arcane_300
  c.func = p.gold_300
  c.attr = p.gold_500
  c.string = p.success_fg
  c.type = p.info_fg
  c.special = p.teal_400

  -- status
  c.error = p.danger_base
  c.warning = p.warning_base
  c.info = p.info_base
  c.hint = p.note_base
  c.git_add = p.success_base
  c.git_change = p.info_base
  c.git_delete = p.danger_base

  -- accents
  c.cursor = p.gold_500
  c.accent = p.gold_500
  c.match = p.gold_500

  -- derived
  c.diff_text = util.blend(p.info_base, p.navy_950, 0.30)
  local headings = { p.gold_500, p.arcane_200, p.info_fg, p.success_fg, p.teal_400, p.silver_300 }
  for i, color in ipairs(headings) do
    c["h" .. i] = color
    c["h" .. i .. "_bg"] = util.blend(color, p.navy_950, 0.12)
  end

  -- matches ~/.config/ghostty/themes/codeacula
  c.terminal = {
    [0] = p.navy_700, p.danger_base, p.success_base, p.gold_500,
    p.info_base, p.arcane_300, p.teal_400, p.silver_400,
    p.silver_600, p.danger_fg, p.success_fg, p.gold_300,
    p.info_fg, p.arcane_200, p.teal_300, p.ivory_50,
  }

  return c
end

return M
