local M = {}

M.source = "lazy.nvim"

function M.get(c)
  return {
    -- the home button, shown only while home is the active mode
    LazyH1 = { fg = c.bg, bg = c.accent, bold = true },
    LazyH2 = { fg = c.fg_bright, bold = true },
    -- CursorLine is the float bg, so buttons would vanish
    LazyButton = { fg = c.fg, bg = c.navy_800 },
    -- gold text, not a gold fill: LazySpecial paints the "(x)" key over it
    LazyButtonActive = { fg = c.accent, bg = c.bg_highlight, bold = true },
    LazySpecial = { fg = c.special },

    LazyDir = { link = "Directory" },
    -- @markup.link is gold, which chrome reserves for the current thing
    LazyUrl = { fg = c.type, underline = true },
    LazyReasonRuntime = { link = "@function.macro" },
  }
end

return M
