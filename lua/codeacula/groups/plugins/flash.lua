local M = {}

M.source = "flash.nvim"

function M.get(c)
  return {
    -- explicit fg so the backdrop does not pick up italic comment styles
    FlashBackdrop = { fg = c.comment },
    -- IncSearch default would be solid gold too and collide with the labels
    FlashCurrent = { fg = c.gold_300, bg = c.warning_bg, bold = true, underline = true },
    FlashLabel = { fg = c.bg, bg = c.accent, bold = true },
  }
end

return M
