local M = { passed = 0, failed = 0 }

M.root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
M.args = {}

function M.test(name, fn)
  local ok, err = pcall(fn)
  if ok then
    M.passed = M.passed + 1
    print("ok    " .. name)
  else
    M.failed = M.failed + 1
    print("FAIL  " .. name .. "\n      " .. tostring(err))
  end
end

function M.skip(name, reason)
  print("skip  " .. name .. " (" .. reason .. ")")
end

function M.eq(actual, expected, msg)
  if actual ~= expected then
    error(("%s: expected %s, got %s"):format(msg or "eq", vim.inspect(expected), vim.inspect(actual)), 2)
  end
end

function M.truthy(v, msg)
  if not v then
    error(msg or "expected truthy value", 2)
  end
end

function M.read(path)
  local f = assert(io.open(path, "r"))
  local s = f:read("*a")
  f:close()
  return s
end

return M
