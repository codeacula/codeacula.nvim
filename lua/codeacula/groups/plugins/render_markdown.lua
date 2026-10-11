-- render-markdown links every RenderMarkdown* group with `default = true` once at
-- load, so groups set here win. Its combined RenderMarkdown_<fg>_<bg> groups are
-- rebuilt from these on ColorScheme. Links to treesitter/core groups that already
-- carry the right colour (links, math, sign, indent, html comments) are left alone.
local M = {}

M.source = "render-markdown.nvim"

function M.get(c)
  local hl = {
    -- code: default ColorColumn/@label; body and inline share the navy_900 well
    RenderMarkdownCode = { bg = c.navy_900 },
    RenderMarkdownCodeInline = { fg = c.gold_400, bg = c.navy_900 },
    RenderMarkdownCodeInfo = { fg = c.label, bg = c.navy_900 },
    -- ==highlight== defaults to CodeInline, which would read as inline code
    RenderMarkdownInlineHighlight = { fg = c.fg_bright, bg = c.warning_bg },

    -- the quote bar; Quote1-6 link here by default
    RenderMarkdownQuote = { fg = c.gold_500 },

    -- default Normal would leave bullets uncoloured
    RenderMarkdownBullet = { fg = c.label },
    RenderMarkdownDash = { fg = c.border },
    RenderMarkdownChecked = { fg = c.success_base },
    RenderMarkdownUnchecked = { fg = c.fg_dim },
    -- [-] in progress; default @markup.raw would make it look like inline code
    RenderMarkdownTodo = { fg = c.info },

    -- head/row colour only the table border characters, not cell text
    RenderMarkdownTableHead = { fg = c.border },
    RenderMarkdownTableRow = { fg = c.border },

    -- callout groups, by the GitHub callout that uses each:
    -- Info = note, Success = tip, Hint = important, Warn = warning, Error = caution
    RenderMarkdownInfo = { fg = c.note_base },
    RenderMarkdownSuccess = { fg = c.success_base },
    RenderMarkdownHint = { fg = c.info_base },
    RenderMarkdownWarn = { fg = c.warning_base },
    RenderMarkdownError = { fg = c.danger_base },
  }

  -- default H*Bg links are DiffText/DiffAdd/DiffDelete/Visual, which read as diffs
  for i = 1, 6 do
    hl["RenderMarkdownH" .. i] = { fg = c["h" .. i], bold = true }
    hl["RenderMarkdownH" .. i .. "Bg"] = { bg = c["h" .. i .. "_bg"] }
  end

  return hl
end

return M
