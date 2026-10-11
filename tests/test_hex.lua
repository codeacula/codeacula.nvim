local T = require("harness")

T.test("hex literals only in palette.lua", function()
  local offenders = {}
  for _, dir in ipairs({ "lua", "colors" }) do
    for _, file in ipairs(vim.fn.globpath(T.root .. "/" .. dir, "**/*.lua", false, true)) do
      if not file:match("codeacula/palette%.lua$") then
        local n = 0
        for line in T.read(file):gmatch("[^\n]*") do
          n = n + 1
          if line:match("#%x%x%x%x%x%x") then
            table.insert(offenders, file:sub(#T.root + 2) .. ":" .. n)
          end
        end
      end
    end
  end
  T.eq(#offenders, 0, "stray hex at " .. table.concat(offenders, ", "))
end)
