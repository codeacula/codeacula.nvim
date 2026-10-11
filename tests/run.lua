-- Usage: nvim -l tests/run.lua [suite] [suite-arg]
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
vim.opt.rtp:prepend(root)
package.path = root .. "/tests/?.lua;" .. package.path

local T = require("harness")
T.args = { select(2, unpack(_G.arg or {})) }
local suite = (_G.arg or {})[1]

local files = vim.fn.glob(root .. "/tests/test_*.lua", false, true)
table.sort(files)
for _, file in ipairs(files) do
  local name = vim.fn.fnamemodify(file, ":t:r"):gsub("^test_", "")
  if not suite or suite == name then
    dofile(file)
  end
end

print(("\n%d passed, %d failed"):format(T.passed, T.failed))
os.exit(T.failed == 0 and 0 or 1)
