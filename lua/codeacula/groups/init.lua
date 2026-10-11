local M = {}

M.core = { "base", "syntax", "treesitter", "semantic" }

local here = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")

---Module paths: core groups first, then every file in groups/plugins/, alphabetical.
function M.modules()
  local list = {}
  for _, name in ipairs(M.core) do
    if vim.uv.fs_stat(here .. "/" .. name .. ".lua") then
      table.insert(list, "codeacula.groups." .. name)
    end
  end
  local plugins = vim.fn.glob(here .. "/plugins/*.lua", false, true)
  table.sort(plugins)
  for _, file in ipairs(plugins) do
    table.insert(list, "codeacula.groups.plugins." .. vim.fn.fnamemodify(file, ":t:r"))
  end
  return list
end

function M.build(c, opts)
  local hl = {}
  for _, mod in ipairs(M.modules()) do
    for name, spec in pairs(require(mod).get(c, opts)) do
      hl[name] = spec
    end
  end
  return hl
end

return M
