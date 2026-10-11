local M = {}

M.source = "vim-dadbod-ui"

-- dbui_connection_ok/error are set unconditionally with hex in syntax/dbui.vim
-- every time the drawer loads, so they are left alone here.
function M.get(c)
  return {
    -- Operator is plain fg here, which hides the "+" new-query icon
    dbui_new_query = { link = "Added" },
    dbui_help_key = { link = "Special" },

    -- only set by the plugin when undefined; its Info default inverts Normal
    NotificationInfo = { fg = c.info_fg, bg = c.info_bg },
    NotificationWarning = { fg = c.warning_fg, bg = c.warning_bg },
    NotificationError = { fg = c.danger_fg, bg = c.danger_bg },
    EchoNotificationInfo = { link = "MoreMsg" },
    EchoNotificationWarning = { link = "WarningMsg" },
    EchoNotificationError = { link = "ErrorMsg" },
  }
end

return M
