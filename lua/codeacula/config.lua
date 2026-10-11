local M = {}

M.defaults = {
  transparent = false,
  styles = {
    comments = { italic = true },
    keywords = {},
    functions = {},
    variables = {},
  },
  on_colors = nil,
  on_highlights = nil,
}

local TYPES = {
  transparent = "boolean",
  styles = "table",
  on_colors = "function",
  on_highlights = "function",
}

M.options = vim.deepcopy(M.defaults)

function M.setup(opts)
  opts = opts or {}
  local clean = {}
  for key, value in pairs(opts) do
    if not TYPES[key] then
      vim.notify(("codeacula.nvim: unknown option %q ignored"):format(key), vim.log.levels.WARN)
    elseif type(value) ~= TYPES[key] then
      vim.notify(("codeacula.nvim: option %q must be a %s"):format(key, TYPES[key]), vim.log.levels.WARN)
    else
      clean[key] = value
    end
  end
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), clean)
end

return M
