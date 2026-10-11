local config = require("codeacula.config")

local M = {}

function M.setup(opts)
  config.setup(opts)
end

local function report(hook, err)
  vim.notify(("codeacula.nvim: %s failed, ignored: %s"):format(hook, err), vim.log.levels.ERROR)
end

---Run a user hook on a copy so a hook that errors halfway leaves no trace.
local function run_hook(hook, name, value, ...)
  if not hook then
    return value
  end
  local copy = vim.deepcopy(value)
  local ok, err = pcall(hook, copy, ...)
  if not ok then
    report(name, err)
    return value
  end
  return copy
end

---Resolved colours (palette tokens + roles), after `on_colors`.
function M.colors(opts)
  opts = opts or config.options
  local c = require("codeacula.theme").resolve(require("codeacula.palette"))
  return run_hook(opts.on_colors, "on_colors", c)
end

function M.load()
  local opts = config.options
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "codeacula"

  local c = M.colors(opts)
  local hl = require("codeacula.groups").build(c, opts)
  hl = run_hook(opts.on_highlights, "on_highlights", hl, c)

  for name, spec in pairs(hl) do
    vim.api.nvim_set_hl(0, name, spec)
  end
  for i = 0, 15 do
    vim.g["terminal_color_" .. i] = c.terminal[i]
  end
end

return M
