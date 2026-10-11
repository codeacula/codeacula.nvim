-- Write the current buffer as HTML to $CODEACULA_HTML_OUT. Loads tohtml by path:
-- 0.12 ships it as the opt package nvim.tohtml, and configs that disable the
-- tohtml plugin (LazyVim's lazy.lua does) also block require("tohtml").
local rt = vim.env.VIMRUNTIME
local file = rt .. "/pack/dist/opt/nvim.tohtml/lua/tohtml.lua"
if not vim.uv.fs_stat(file) then
  file = rt .. "/lua/tohtml.lua"
end
vim.fn.writefile(dofile(file).tohtml(0), vim.env.CODEACULA_HTML_OUT)
