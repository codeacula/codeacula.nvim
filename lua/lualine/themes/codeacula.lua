local c = require("codeacula").colors()

local function mode(color)
  return {
    a = { fg = c.bg, bg = color, gui = "bold" },
    b = { fg = c.fg_bright, bg = c.bg_highlight },
    c = { fg = c.fg, bg = c.bg_statusline },
  }
end

local inactive = { fg = c.silver_600, bg = c.bg_statusline }

return {
  normal = mode(c.gold_500),
  insert = mode(c.success_base),
  visual = mode(c.arcane_300),
  replace = mode(c.danger_base),
  command = mode(c.info_base),
  terminal = mode(c.special),
  inactive = { a = inactive, b = inactive, c = inactive },
}
