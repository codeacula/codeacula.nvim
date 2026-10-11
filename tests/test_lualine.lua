local T = require("harness")

T.test("lualine theme modes", function()
  package.loaded["lualine.themes.codeacula"] = nil
  local theme = require("lualine.themes.codeacula")
  local c = require("codeacula").colors()
  local want = {
    normal = c.gold_500, insert = c.success_base, visual = c.arcane_300,
    replace = c.danger_base, command = c.info_base, terminal = c.special,
  }
  for mode, color in pairs(want) do
    T.eq(theme[mode].a.bg, color, mode .. ".a.bg")
    T.eq(theme[mode].a.fg, c.bg, mode .. ".a.fg")
    T.eq(theme[mode].b.bg, c.bg_highlight, mode .. ".b.bg")
    T.eq(theme[mode].c.bg, c.bg_statusline, mode .. ".c.bg")
  end
  T.eq(theme.inactive.a.fg, c.silver_600, "inactive fg")
end)
