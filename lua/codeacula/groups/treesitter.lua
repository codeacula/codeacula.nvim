local M = {}

function M.get(c, opts)
  local s = opts.styles
  local function style(spec, extra)
    return vim.tbl_extend("force", spec, extra or {})
  end

  local hl = {
    ["@variable"] = style({ fg = c.fg }, s.variables),
    ["@variable.builtin"] = { fg = c.special, italic = true },
    ["@variable.parameter"] = { fg = c.fg },
    ["@variable.parameter.builtin"] = { fg = c.special, italic = true },
    ["@variable.member"] = { fg = c.fg_bright },
    ["@property"] = { fg = c.fg_bright },
    ["@module"] = { fg = c.fg_bright },
    ["@module.builtin"] = { fg = c.special },
    ["@label"] = { fg = c.label },

    ["@constant"] = { fg = c.keyword },
    ["@constant.builtin"] = { fg = c.keyword },
    ["@constant.macro"] = { fg = c.special },
    ["@boolean"] = { fg = c.keyword },
    ["@number"] = { fg = c.keyword },
    ["@number.float"] = { fg = c.keyword },

    ["@string"] = { fg = c.string },
    ["@string.documentation"] = { fg = c.string },
    ["@string.regexp"] = { fg = c.attr },
    ["@string.escape"] = { fg = c.special },
    ["@string.special"] = { fg = c.special },
    ["@string.special.symbol"] = { fg = c.special },
    ["@string.special.path"] = { fg = c.string },
    ["@string.special.url"] = { fg = c.gold_300, underline = true },
    ["@character"] = { fg = c.string },
    ["@character.special"] = { fg = c.special },

    ["@type"] = { fg = c.type },
    ["@type.builtin"] = { fg = c.type, italic = true },
    ["@type.definition"] = { fg = c.type },
    ["@attribute"] = { fg = c.type },
    ["@attribute.builtin"] = { fg = c.type, italic = true },

    ["@function"] = style({ fg = c.func }, s.functions),
    ["@function.call"] = style({ fg = c.func }, s.functions),
    ["@function.method"] = style({ fg = c.func }, s.functions),
    ["@function.method.call"] = style({ fg = c.func }, s.functions),
    ["@function.builtin"] = { fg = c.special },
    ["@function.macro"] = { fg = c.special },
    ["@constructor"] = { fg = c.func },
    ["@operator"] = { fg = c.fg },

    ["@keyword"] = style({ fg = c.keyword }, s.keywords),

    ["@punctuation.delimiter"] = { fg = c.fg_dim },
    ["@punctuation.bracket"] = { fg = c.fg_dim },
    ["@punctuation.special"] = { fg = c.fg_dim },

    ["@comment"] = style({ fg = c.comment }, s.comments),
    ["@comment.documentation"] = style({ fg = c.doc_comment }, s.comments),
    ["@comment.error"] = { fg = c.danger_fg, bg = c.danger_bg, bold = true },
    ["@comment.warning"] = { fg = c.warning_fg, bg = c.warning_bg, bold = true },
    ["@comment.todo"] = { fg = c.info_fg, bg = c.info_bg, bold = true },
    ["@comment.note"] = { fg = c.note_fg, bg = c.note_bg, bold = true },

    ["@tag"] = { fg = c.type },
    ["@tag.builtin"] = { fg = c.type },
    ["@tag.attribute"] = { fg = c.attr },
    ["@tag.delimiter"] = { fg = c.fg_dim },

    ["@markup.strong"] = { fg = c.ivory_50, bold = true },
    ["@markup.italic"] = { fg = c.ivory_200, italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = c.fg_bright, bold = true },
    ["@markup.quote"] = { fg = c.fg_dim, italic = true },
    ["@markup.math"] = { fg = c.special },
    ["@markup.link"] = { fg = c.gold_300 },
    ["@markup.link.label"] = { fg = c.gold_300 },
    ["@markup.link.url"] = { fg = c.gold_300, underline = true },
    ["@markup.raw"] = { fg = c.gold_400 },
    ["@markup.raw.block"] = { fg = c.fg },
    ["@markup.raw.markdown_inline"] = { fg = c.gold_400, bg = c.navy_900 },
    ["@markup.list"] = { fg = c.label },
    ["@markup.list.checked"] = { fg = c.success_base },
    ["@markup.list.unchecked"] = { fg = c.fg_dim },

    ["@diff.plus"] = { fg = c.git_add },
    ["@diff.minus"] = { fg = c.git_delete },
    ["@diff.delta"] = { fg = c.git_change },

    ["@none"] = {},

    -- pre-0.10 capture names some plugins still emit (noice hover docs)
    ["@text.title"] = { link = "@markup.heading" },
    ["@text.reference"] = { link = "@markup.link" },
    ["@parameter"] = { link = "@variable.parameter" },
  }

  for i = 1, 6 do
    hl["@markup.heading." .. i] = { fg = c["h" .. i], bold = true }
  end

  -- data-file keys take Halcyon's cyan slot (celestial)
  for _, lang in ipairs({ "json", "jsonc", "json5", "yaml", "toml" }) do
    hl["@property." .. lang] = { fg = c.type }
  end

  return hl
end

return M
