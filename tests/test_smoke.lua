local T = require("harness")

local function load(opts)
  require("codeacula").setup(opts or {})
  vim.cmd.colorscheme("codeacula")
end

local function hex(n)
  return n and string.format("#%06x", n) or nil
end

T.test("colorscheme loads", function()
  load()
  T.eq(vim.g.colors_name, "codeacula", "colors_name")
  T.eq(vim.o.background, "dark", "background")
  local c = require("codeacula").colors()
  T.eq(hex(vim.api.nvim_get_hl(0, { name = "Normal" }).bg), c.bg, "Normal bg")
  T.eq(hex(vim.api.nvim_get_hl(0, { name = "Normal" }).fg), c.fg, "Normal fg")
end)

T.test("every link target exists", function()
  load()
  local opts = require("codeacula.config").options
  local hl = require("codeacula.groups").build(require("codeacula").colors(), opts)
  local missing = {}
  for name, spec in pairs(hl) do
    if spec.link and vim.fn.hlexists(spec.link) == 0 then
      table.insert(missing, name .. " -> " .. spec.link)
    end
  end
  T.eq(#missing, 0, table.concat(missing, ", "))
end)

T.test("no group defined by two modules", function()
  local c = require("codeacula").colors()
  local opts = require("codeacula.config").options
  local seen, dupes = {}, {}
  for _, mod in ipairs(require("codeacula.groups").modules()) do
    for name in pairs(require(mod).get(c, opts)) do
      if seen[name] then
        table.insert(dupes, name .. " (" .. seen[name] .. ", " .. mod .. ")")
      end
      seen[name] = mod
    end
  end
  T.eq(#dupes, 0, table.concat(dupes, "; "))
end)

T.test("terminal colours set", function()
  load()
  local c = require("codeacula").colors()
  for i = 0, 15 do
    T.eq(vim.g["terminal_color_" .. i], c.terminal[i], "terminal_color_" .. i)
  end
end)

T.test("transparent clears editor background", function()
  load({ transparent = true })
  T.eq(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, nil, "Normal bg")
  T.truthy(vim.api.nvim_get_hl(0, { name = "NormalFloat" }).bg, "floats stay opaque")
  load()
end)

T.test("on_colors and on_highlights apply", function()
  load({
    on_colors = function(c) c.fg = "#ff0000" end,
    on_highlights = function(hl) hl.Title = { fg = "#00ff00" } end,
  })
  T.eq(hex(vim.api.nvim_get_hl(0, { name = "Normal" }).fg), "#ff0000", "on_colors")
  T.eq(hex(vim.api.nvim_get_hl(0, { name = "Title" }).fg), "#00ff00", "on_highlights")
  load()
end)

T.test("failing hooks notify and theme still applies", function()
  local notes = {}
  local orig = vim.notify
  vim.notify = function(msg, level) table.insert(notes, { msg = msg, level = level }) end
  load({
    on_colors = function(c) c.fg = "#ff0000"; error("boom") end,
    on_highlights = function() error("bang") end,
  })
  vim.notify = orig
  local c = require("codeacula").colors({})
  T.eq(hex(vim.api.nvim_get_hl(0, { name = "Normal" }).fg), c.fg, "partial on_colors edit discarded")
  T.eq(#notes, 2, "two notifications")
  T.eq(notes[1].level, vim.log.levels.ERROR, "error level")
  load()
end)

T.test("unknown and mistyped options warn", function()
  local notes = {}
  local orig = vim.notify
  vim.notify = function(msg, level) table.insert(notes, { msg = msg, level = level }) end
  require("codeacula").setup({ bogus = 1, transparent = "yes" })
  vim.notify = orig
  T.eq(#notes, 2, "two warnings")
  T.eq(require("codeacula.config").options.transparent, false, "bad value dropped")
  require("codeacula").setup({})
end)
