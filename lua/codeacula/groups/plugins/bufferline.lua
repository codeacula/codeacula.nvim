-- bufferline rebuilds every BufferLine* group on ColorScheme from colours it
-- derives from Normal/Comment/Diagnostic*/TabLineSel, but with the default
-- `themable = true` (LazyVim keeps it) it sets them with `default = true`, so
-- groups set here survive.
--
-- Its runtime-composed groups (per-filetype icons, buffer groups, custom areas)
-- take their bg from that internal derived table, not from the groups, so the
-- background/visible states (shaded navy_950) are left alone to avoid seams.
-- Only selected-state groups are overridden; their derived bg is Normal's bg.
-- Their underline is dropped, so `indicator.style = "underline"` users should
-- set `highlights` in their bufferline opts instead.
local M = {}

M.source = "bufferline.nvim"
-- names are generated from snake_case config keys (indicator_selected ->
-- BufferLineIndicatorSelected), so they never appear literally in the source
M.dynamic = { "BufferLine" }

function M.get(c, opts)
  local bg = opts.transparent and "NONE" or c.bg

  return {
    -- default is TabLineSel's fg (silver); the current buffer is the one gold thing
    BufferLineIndicatorSelected = { fg = c.accent, bg = bg },
    BufferLineBufferSelected = { fg = c.fg_bright, bg = bg, bold = true, italic = true },
  }
end

return M
