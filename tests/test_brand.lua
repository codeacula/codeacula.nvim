local T = require("harness")
local brand = vim.fn.expand("~/brand.css")

local function parse(css)
  local vars = {}
  for name, value in css:gmatch("%-%-([%w%-]+):%s*([^;]+);") do
    vars[name] = vim.trim(value)
  end
  local function resolve(name, depth)
    local v = vars[name]
    if not v or depth > 10 then return nil end
    local ref = v:match("^var%(%-%-([%w%-]+)%)$")
    return ref and resolve(ref, depth + 1) or v:lower()
  end
  return resolve
end

if vim.fn.filereadable(brand) == 0 then
  T.skip("palette matches brand.css", "~/brand.css not present")
else
  T.test("palette matches brand.css", function()
    local resolve = parse(T.read(brand))
    local drift = {}
    for token, hex in pairs(require("codeacula.palette")) do
      local css = token:gsub("_", "-")
      local want = resolve(css, 0)
      if want ~= hex then
        table.insert(drift, ("%s: palette %s, brand %s"):format(token, hex, tostring(want)))
      end
    end
    table.sort(drift)
    T.eq(#drift, 0, "drift:\n      " .. table.concat(drift, "\n      "))
  end)
end
