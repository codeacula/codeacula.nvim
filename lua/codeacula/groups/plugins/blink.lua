local M = {}

M.source = "blink.cmp"

-- BlinkCmpKind<Kind> names are built from blink.cmp.types.CompletionItemKind
M.dynamic = { "BlinkCmpKind" }

local KINDS = {
  Text = "fg",
  Method = "func",
  Function = "func",
  Constructor = "func",
  Field = "fg_bright",
  Variable = "fg_bright",
  Class = "type",
  Interface = "type",
  Module = "fg_bright",
  Property = "fg_bright",
  Unit = "keyword",
  Value = "keyword",
  Enum = "type",
  Keyword = "keyword",
  Snippet = "special",
  Color = "special",
  File = "fg",
  Reference = "fg_bright",
  Folder = "type",
  EnumMember = "keyword",
  Constant = "keyword",
  Struct = "type",
  Event = "type",
  Operator = "special",
  TypeParameter = "type",
}

function M.get(c)
  local hl = {
    -- borders default to Pmenu/NormalFloat, which draws them in body text colour
    BlinkCmpMenuBorder = { link = "FloatBorder" },
    BlinkCmpDocBorder = { link = "FloatBorder" },
    BlinkCmpDocSeparator = { link = "FloatBorder" },
    BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },

    -- unset unless use_nvim_cmp_as_default; fg only so the selected row's bg shows through
    BlinkCmpLabelMatch = { fg = c.match, bold = true },
    BlinkCmpLabelDeprecated = { fg = c.comment, strikethrough = true },
    BlinkCmpLabelDetail = { fg = c.fg_dim },
    BlinkCmpLabelDescription = { fg = c.fg_dim },
    BlinkCmpSource = { fg = c.fg_dim },

    -- NonText (navy_600) is too faint to read as a suggestion
    BlinkCmpGhostText = { fg = c.comment, italic = true },

    BlinkCmpKind = { fg = c.type },
    BlinkCmpKindUnknown = { link = "BlinkCmpKind" },
  }
  for kind, role in pairs(KINDS) do
    hl["BlinkCmpKind" .. kind] = { fg = c[role] }
  end
  return hl
end

return M
