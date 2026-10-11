local T = require("harness")
local lazy = vim.fn.stdpath("data") .. "/lazy/"
local only = T.args[1]

local EXT = { lua = true, vim = true, txt = true, md = true }

local function corpus(dir)
  local parts = {}
  for _, file in ipairs(vim.fs.find(function(name)
    return EXT[name:match("%.(%w+)$") or ""] or false
  end, { path = dir, type = "file", limit = math.huge })) do
    table.insert(parts, T.read(file))
  end
  return table.concat(parts, "\n")
end

local core = {}
do
  local c = require("codeacula").colors({})
  local opts = require("codeacula.config").defaults
  for _, name in ipairs(require("codeacula.groups").core) do
    local ok, mod = pcall(require, "codeacula.groups." .. name)
    if ok then
      for group in pairs(mod.get(c, opts)) do core[group] = true end
    end
  end
end

local files = vim.fn.glob(T.root .. "/lua/codeacula/groups/plugins/*.lua", false, true)
table.sort(files)
for _, file in ipairs(files) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  if not only or only == name then
    local mod = require("codeacula.groups.plugins." .. name)
    local label = "plugin " .. name
    T.test(label .. " contract", function()
      T.truthy(type(mod.source) == "string", "M.source must be a string")
      T.truthy(type(mod.get) == "function", "M.get must be a function")
      local hl = mod.get(require("codeacula").colors({}), require("codeacula.config").defaults)
      T.truthy(type(hl) == "table", "get() must return a table")
      local clash = {}
      for group in pairs(hl) do
        if core[group] then table.insert(clash, group) end
      end
      T.eq(#clash, 0, "redefines core groups: " .. table.concat(clash, ", "))
    end)
    local dir = lazy .. mod.source
    if vim.fn.isdirectory(dir) == 0 then
      T.skip(label .. " groups exist in source", dir .. " not installed")
    else
      T.test(label .. " groups exist in source", function()
        local text = corpus(dir)
        local hl = mod.get(require("codeacula").colors({}), require("codeacula.config").defaults)
        local unknown = {}
        for group in pairs(hl) do
          local found = text:find("%f[%w_@]" .. vim.pesc(group) .. "%f[^%w_.]")
          if not found then
            for _, prefix in ipairs(mod.dynamic or {}) do
              if group:sub(1, #prefix) == prefix and text:find(prefix, 1, true) then
                found = true
                break
              end
            end
          end
          if not found then table.insert(unknown, group) end
        end
        table.sort(unknown)
        T.eq(#unknown, 0, "not found in " .. mod.source .. ": " .. table.concat(unknown, ", "))
      end)
    end
  end
end
