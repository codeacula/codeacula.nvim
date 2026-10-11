# codeacula.nvim

A dark Neovim colorscheme that follows the layout of
[Halcyon](https://halcyon-theme.netlify.app/) but takes every colour from the
Codeacula palette. Body text is a muted silver on deep navy, and colour is
saved for the things you scan for: lavender keywords, pale gold functions,
sage strings and sky-blue types. Comments are dim and italic, punctuation
recedes, and gold in the UI marks only the cursor and the current item.

It is plain Lua with no dependencies and no build step, and it covers
treesitter, LSP semantic tokens, the legacy syntax groups, and the plugins in a
typical LazyVim setup.

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ "codeacula/codeacula.nvim", lazy = false, priority = 1000, opts = {} }
```

Then pick it as your colorscheme:

```vim
:colorscheme codeacula
```

### LazyVim with a local checkout

This is how I run it. The plugin loads from a local clone when one exists and
falls back to GitHub when it does not, so the same config works on every
machine.

```lua
-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  { "codeacula/codeacula.nvim", dev = true, lazy = false, priority = 1000, opts = {} },
  { "LazyVim/LazyVim", opts = { colorscheme = "codeacula" } },
}
```

In `lua/config/lazy.lua`, add this to the `require("lazy").setup({...})` table:

```lua
dev = { path = "~/Storage/Projects", fallback = true },
```

## Options

`setup()` is optional. `:colorscheme codeacula` works with the defaults below.

```lua
require("codeacula").setup({
  transparent = false,  -- Normal/NormalNC/SignColumn/etc. bg = NONE
  styles = {
    comments  = { italic = true },
    keywords  = {},
    functions = {},
    variables = {},
  },
  on_colors = function(c) end,
  on_highlights = function(hl, c) end,
})
```

`on_colors(c)` runs after the roles resolve, so you can change a role or token
in one place. `on_highlights(hl, c)` runs after every group is built and
before they are applied. If either hook errors, the error is reported and the
theme loads without it. Unknown option keys produce a warning instead of an
error.

## Lualine

The theme ships a lualine theme under the same name. With `theme = "auto"`,
lualine picks it up on its own; you can also set `theme = "codeacula"`.

## Palette

Every colour lives in [`lua/codeacula/palette.lua`](lua/codeacula/palette.lua),
named after the brand tokens (`navy_950`, `gold_300`, `arcane_200`, and so
on). It is the only file in `lua/` that contains hex values, so changing a
colour is a one-line edit. `lua/codeacula/theme.lua` maps those tokens to
roles such as `keyword`, `func` and `string`.

The palette is copied by hand from the brand stylesheet. When `~/brand.css` is
present, the brand drift test checks every token against it and fails on any
mismatch. Without the file, the test is skipped with a notice.

## Testing

The tests run headless and need nothing beyond Neovim:

```sh
nvim -l tests/run.lua
```

They cover loading and link targets, stray hex literals, contrast floors for
every syntax role, brand drift, and plugin group names checked against each
plugin's installed source.

To look at the result, render the sample files through your real config:

```sh
tests/render.sh
```

This writes one HTML file per sample to `build/review/`.

## License

MIT. See [LICENSE](LICENSE).
