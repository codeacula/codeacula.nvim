local T = require("harness")

local SYNTAX = { "fg", "fg_bright", "keyword", "label", "func", "attr", "string", "type", "special", "error" }
local DIM = { "fg_dim", "comment" }

T.test("syntax roles >= 4.5 on bg and bg_visual", function()
  local util = require("codeacula.util")
  local c = require("codeacula.theme").resolve(require("codeacula.palette"))
  local low = {}
  for _, role in ipairs(SYNTAX) do
    for _, surface in ipairs({ "bg", "bg_visual" }) do
      local ratio = util.contrast(c[role], c[surface])
      if ratio < 4.5 then
        table.insert(low, ("%s on %s = %.2f"):format(role, surface, ratio))
      end
    end
  end
  T.eq(#low, 0, table.concat(low, "; "))
end)

T.test("dim roles >= 3.0 on bg", function()
  local util = require("codeacula.util")
  local c = require("codeacula.theme").resolve(require("codeacula.palette"))
  for _, role in ipairs(DIM) do
    T.truthy(util.contrast(c[role], c.bg) >= 3.0, role .. " below 3.0")
  end
end)

T.test("util.contrast matches WCAG reference", function()
  local util = require("codeacula.util")
  local p = require("codeacula.palette")
  local ratio = util.contrast(p.silver_400, p.navy_950)
  T.truthy(ratio > 8.0 and ratio < 8.1, ("silver_400 on navy_950 = %.3f, want ~8.03"):format(ratio))
  T.eq(util.blend(p.ivory_50, p.navy_950, 1), p.ivory_50, "alpha 1 returns fg")
  T.eq(util.blend(p.ivory_50, p.navy_950, 0), p.navy_950, "alpha 0 returns bg")
end)

T.test("terminal colours match Ghostty theme", function()
  local c = require("codeacula.theme").resolve(require("codeacula.palette"))
  local p = require("codeacula.palette")
  local want = {
    [0] = p.navy_700, p.danger_base, p.success_base, p.gold_500, p.info_base, p.arcane_300, p.teal_400, p.silver_400,
    p.silver_600, p.danger_fg, p.success_fg, p.gold_300, p.info_fg, p.arcane_200, p.teal_300, p.ivory_50,
  }
  for i = 0, 15 do
    T.eq(c.terminal[i], want[i], "terminal_color_" .. i)
  end
end)
