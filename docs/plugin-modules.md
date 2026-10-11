# Plugin modules

One file per plugin in `lua/codeacula/groups/plugins/`, auto-discovered.

## Contract
- `M.source` — directory name under `~/.local/share/nvim/lazy/`.
- `M.dynamic` — optional list of prefixes for names the plugin builds at runtime
  (e.g. `"BlinkCmpKind"` .. kind). Use only when the full name never appears
  literally in the plugin's source or docs.
- `M.get(c, opts)` returns `{ Group = spec }`. No hex literals, no `vim.api`.

## How to choose groups
1. Enumerate the plugin's groups from its source and docs (`nvim_set_hl`,
   `hl_group`, `highlight default link`, `:h <plugin>-highlights`).
2. Set a group only when its default (usually a link to a core group) would look
   wrong or lose meaning under codeacula. Prefer `{ link = "<CoreGroup>" }` when
   a core group already expresses the intent.
3. Never redefine a core group (base/syntax/treesitter/semantic).

## Colour rules
- Floats/panels `c.bg_float`, borders `c.border` on `c.bg_float`, titles
  `c.fg_bright` bold.
- Selected row `c.bg_highlight` + `c.fg_bright`. Cursorline-style rows `c.cursorline`.
- Fuzzy-match characters `c.match` bold (D11).
- Gold (`c.accent`) otherwise only for the single "current" thing.
- Directories `c.type`; file names `c.fg_bright`; counts/meta `c.fg_dim`;
  dim hints `c.comment`.
- Diagnostics/status use `c.error c.warning c.info c.hint`; tinted fills use
  `c.danger_bg c.warning_bg c.info_bg c.note_bg c.success_bg`.
- Git: `c.git_add c.git_change c.git_delete`.
- LSP kinds (completion, outline, navic-style): Function/Method/Constructor
  `c.func`; Class/Struct/Interface/Enum/Type `c.type`; Keyword/Constant/Number/
  Boolean `c.keyword`; String `c.string`; Variable/Field/Property `c.fg_bright`;
  Module/Namespace/Package `c.fg_bright`; Snippet/Macro/Operator `c.special`;
  EnumMember `c.keyword`; Event/TypeParameter `c.type`; Folder `c.type`; File `c.fg`.
- Plugins that derive colours from setup config instead of highlight groups:
  return `{}` and document why in a comment at the top of the module.
