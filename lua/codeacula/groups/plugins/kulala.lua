local M = {}

M.source = "kulala.nvim"

-- Only the OpenAPI method badges, whose defaults are Swagger hex colours.
-- The plugin sets them with default = true, so these also win over
-- openapi_panel.highlights.method_* in the user's kulala config.
-- The other KulalaOpenAPI* groups default-link to core groups via
-- openapi_panel.highlights, so setting them would override user config.
-- KulalaTab/KulalaTabSel and ui.syntax_hl are re-set unconditionally by the
-- plugin, so a colorscheme cannot own them.
function M.get(c)
  return {
    KulalaOpenAPIMethodGet = { fg = c.info, bold = true },
    KulalaOpenAPIMethodPost = { fg = c.success_base, bold = true },
    KulalaOpenAPIMethodPut = { fg = c.label, bold = true },
    KulalaOpenAPIMethodPatch = { fg = c.special, bold = true },
    KulalaOpenAPIMethodDelete = { fg = c.error, bold = true },
    KulalaOpenAPIMethodHead = { fg = c.fg_dim, bold = true },
    KulalaOpenAPIMethodOptions = { fg = c.fg_dim, bold = true },
  }
end

return M
