local M = {}

M.source = "noice.nvim"

-- Per-format names are built as "Noice" .. "CmdlineIcon" .. Kind in
-- noice/config/cmdline.lua. nui.nvim defines no groups of its own; noice
-- points every nui window at Noice* groups through winhighlight.
M.dynamic = { "NoiceCmdlineIcon", "NoiceCmdlinePopupTitle" }

-- cmdline format kinds: the defaults plus the inc_rename preset.
-- Search is not gold: D7 keeps gold for the current match, not the prompt icon.
local MODES = {
  Cmdline = "info",
  Search = "special",
  Filter = "string",
  Lua = "type",
  Help = "hint",
  Calculator = "keyword",
  Input = "label",
  IncRename = "error",
}

local KINDS = {
  Color = "special",
  Function = "func",
  Class = "type",
  Method = "func",
  Constructor = "func",
  Interface = "type",
  Module = "fg_bright",
  Struct = "type",
  Keyword = "keyword",
  Value = "keyword",
  Property = "fg_bright",
  Constant = "keyword",
  Snippet = "special",
  Folder = "type",
  Text = "fg",
  EnumMember = "keyword",
  Unit = "keyword",
  Field = "fg_bright",
  File = "fg",
  Variable = "fg_bright",
  Enum = "type",
}

function M.get(c)
  local hl = {
    -- default Normal would make the popup indistinguishable from the editor
    NoiceCmdlinePopup = { link = "NormalFloat" },
    NoiceCmdlinePopupBorder = { link = "FloatBorder" },
    NoiceCmdlinePopupBorderSearch = { link = "FloatBorder" },
    NoiceCmdlinePopupTitle = { link = "FloatTitle" },
    NoiceCmdlineIcon = { fg = c.info },

    NoiceConfirm = { link = "NormalFloat" },
    NoiceConfirmBorder = { link = "FloatBorder" },
    -- CursorLine/Visual vanish or turn purple on a navy_900 float; the default
    -- choice reads as the selected row rather than gold (D7)
    NoiceFormatConfirm = { fg = c.fg, bg = c.navy_800 },
    NoiceFormatConfirmDefault = { fg = c.fg_bright, bg = c.bg_highlight, bold = true },

    NoicePopupmenuMatch = { fg = c.match, bold = true },
    NoiceCompletionItemMenu = { fg = c.fg_dim },
    NoiceCompletionItemKindDefault = { fg = c.type },

    -- default copies Search (gold tint); progress is not a search hit
    NoiceFormatProgressDone = { fg = c.fg_bright, bg = c.bg_highlight },
    NoiceLspProgressTitle = { fg = c.fg_dim },

    -- NonText (navy_600) is too faint for text
    NoiceFormatEvent = { fg = c.comment },
    NoiceFormatKind = { fg = c.comment },
    NoiceFormatDate = { fg = c.fg_dim },
    NoiceFormatLevelDebug = { fg = c.comment },
    NoiceFormatLevelTrace = { fg = c.comment },
    NoiceFormatLevelOff = { fg = c.comment },
  }
  for mode, role in pairs(MODES) do
    hl["NoiceCmdlineIcon" .. mode] = { fg = c[role] }
    -- per-mode titles default-link to the per-mode border, which is border-dim here
    hl["NoiceCmdlinePopupTitle" .. mode] = { link = "FloatTitle" }
  end
  for kind, role in pairs(KINDS) do
    hl["NoiceCompletionItemKind" .. kind] = { fg = c[role] }
  end
  return hl
end

return M
