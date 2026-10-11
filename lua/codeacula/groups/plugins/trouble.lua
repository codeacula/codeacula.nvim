local M = {}

M.source = "trouble.nvim"

function M.get(c)
  return {
    -- default links to Normal, whose bg would punch holes in the panel
    TroubleText = { fg = c.fg },
    TroubleIconFile = { fg = c.fg },

    TroubleFilename = { fg = c.fg_bright },
    TroubleIconDirectory = { link = "Directory" },
    TroublePos = { fg = c.fg_dim },
    TroubleCount = { fg = c.fg_dim },

    -- LSP kinds set directly so user syntax styles (italic functions etc.) stay out of icons
    TroubleIconArray = { fg = c.fg_dim },
    TroubleIconBoolean = { fg = c.keyword },
    TroubleIconClass = { fg = c.type },
    TroubleIconConstant = { fg = c.keyword },
    TroubleIconConstructor = { fg = c.func },
    TroubleIconEnum = { fg = c.type },
    TroubleIconEnumMember = { fg = c.keyword },
    TroubleIconEvent = { fg = c.type },
    TroubleIconField = { fg = c.fg_bright },
    TroubleIconFunction = { fg = c.func },
    TroubleIconInterface = { fg = c.type },
    TroubleIconKey = { fg = c.keyword },
    TroubleIconMethod = { fg = c.func },
    TroubleIconModule = { fg = c.fg_bright },
    TroubleIconNamespace = { fg = c.fg_bright },
    TroubleIconNull = { fg = c.keyword },
    TroubleIconNumber = { fg = c.keyword },
    TroubleIconObject = { fg = c.type },
    TroubleIconOperator = { fg = c.special },
    TroubleIconPackage = { fg = c.fg_bright },
    TroubleIconProperty = { fg = c.fg_bright },
    TroubleIconString = { fg = c.string },
    TroubleIconStruct = { fg = c.type },
    TroubleIconTypeParameter = { fg = c.type },
    TroubleIconVariable = { fg = c.fg_bright },
  }
end

return M
