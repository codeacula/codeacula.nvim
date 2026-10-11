-- mini.icons colours glyphs by hue name. The defaults link to Function,
-- Diagnostic* and Constant, which would make icons follow syntax and status
-- roles (gold functions, purple constants); pin each hue to its nearest brand
-- colour instead.
local M = {}

M.source = "mini.icons"

function M.get(c)
  return {
    MiniIconsAzure = { fg = c.info_fg },
    MiniIconsBlue = { fg = c.info_base },
    MiniIconsCyan = { fg = c.teal_400 },
    MiniIconsGreen = { fg = c.success_base },
    MiniIconsGrey = { fg = c.silver_400 },
    MiniIconsOrange = { fg = c.gold_500 },
    MiniIconsPurple = { fg = c.arcane_300 },
    MiniIconsRed = { fg = c.danger_base },
    MiniIconsYellow = { fg = c.gold_300 },
  }
end

return M
