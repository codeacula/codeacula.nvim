-- alpha defines no highlight groups; elements are coloured by whatever `hl`
-- names the dashboard config passes at runtime. LazyVim's alpha extra
-- (extras/ui/alpha.lua) passes AlphaHeader, AlphaButtons, AlphaShortcut and
-- AlphaFooter, which nothing defines, so without these they render as plain
-- Normal text.
local M = {}

-- the names live in LazyVim's alpha extra, not in alpha-nvim (whose only
-- "Alpha*" strings are User autocmd and command names), so check them there
M.source = "LazyVim"

function M.get(c)
  return {
    AlphaHeader = { fg = c.keyword },
    AlphaButtons = { fg = c.fg },
    AlphaShortcut = { fg = c.special, bold = true },
    AlphaFooter = { fg = c.comment, italic = true },
  }
end

return M
