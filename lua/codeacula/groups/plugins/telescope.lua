local M = {}

M.source = "telescope.nvim"

function M.get(c)
  return {
    -- default chain is Normal -> Border -> Title, so the float would sit on the
    -- editor bg with borders and titles in plain text colour
    TelescopeNormal = { link = "NormalFloat" },
    TelescopeBorder = { link = "FloatBorder" },
    TelescopeTitle = { link = "FloatTitle" },

    TelescopeSelection = { fg = c.fg_bright, bg = c.bg_highlight },
    TelescopeSelectionCaret = { fg = c.accent, bg = c.bg_highlight },
    TelescopeMultiIcon = { fg = c.type },
    TelescopeMatching = { fg = c.match, bold = true },
    TelescopePromptPrefix = { fg = c.special },
    -- NonText (navy_600) all but vanishes on the float bg
    TelescopePromptCounter = { fg = c.fg_dim },
    TelescopePreviewHyphen = { fg = c.comment },
    TelescopeResultsDiffUntracked = { fg = c.comment },

    -- DiffAdd/DiffChange/DiffDelete are background fills; these colour status letters
    TelescopeResultsDiffAdd = { fg = c.git_add },
    TelescopeResultsDiffChange = { fg = c.git_change },
    TelescopeResultsDiffDelete = { fg = c.git_delete },

    TelescopeResultsLineNr = { fg = c.fg_dim },

    -- LSP kinds set directly so user syntax styles stay out of result lists;
    -- Method and Struct link to groups Neovim does not define
    TelescopeResultsClass = { fg = c.type },
    TelescopeResultsField = { fg = c.fg_bright },
    TelescopeResultsFunction = { fg = c.func },
    TelescopeResultsMethod = { fg = c.func },
    -- make_entry.lua maps the LSP Property kind to this group
    TelescopeResultsOperator = { fg = c.fg_bright },
    TelescopeResultsStruct = { fg = c.type },
    TelescopeResultsVariable = { fg = c.fg_bright },
  }
end

return M
