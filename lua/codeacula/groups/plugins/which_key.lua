local M = {}

M.source = "which-key.nvim"

function M.get(c)
  return {
    -- keys default to Function, which would fill a whole column with gold
    WhichKey = { fg = c.special },
    -- set directly so user syntax styles (italic keywords/variables) stay out of the menu
    WhichKeyGroup = { fg = c.keyword },
    WhichKeyDesc = { fg = c.fg },
    -- default is @markup.link (gold) for icons with no hue
    WhichKeyIcon = { fg = c.fg_dim },

    -- which-key relinks these to MiniIcons* only while its own default links
    -- exist, which `:hi clear` removes; link them up front so icons match
    -- mini.icons everywhere
    WhichKeyIconAzure = { link = "MiniIconsAzure" },
    WhichKeyIconBlue = { link = "MiniIconsBlue" },
    WhichKeyIconCyan = { link = "MiniIconsCyan" },
    WhichKeyIconGreen = { link = "MiniIconsGreen" },
    WhichKeyIconGrey = { link = "MiniIconsGrey" },
    WhichKeyIconOrange = { link = "MiniIconsOrange" },
    WhichKeyIconPurple = { link = "MiniIconsPurple" },
    WhichKeyIconRed = { link = "MiniIconsRed" },
    WhichKeyIconYellow = { link = "MiniIconsYellow" },
  }
end

return M
