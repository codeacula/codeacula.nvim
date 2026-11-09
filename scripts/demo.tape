# Capture codeacula in a live Neovim session with VHS (https://github.com/charmbracelet/vhs).
# Uses your real config, so plugins, LSP and the statusline show up as they do day to day.
#
# Run from the repo root:   vhs scripts/demo.tape
# Needs: vhs, ttyd, ffmpeg, and a LazyVim-style config (space as leader).
# Paths must stay relative: VHS's parser rejects some absolute paths.

Output assets/demo.gif

Require nvim

Set Shell bash
Set FontFamily "JetBrainsMono Nerd Font"
Set FontSize 16
Set Width 1600
Set Height 1000
Set Padding 0
Set TypingSpeed 60ms
Set Theme { "background": "#0c1220", "foreground": "#a2aabc", "cursor": "#ffd6a0" }

# Diagnostics are off: the samples are not in a real project, so the language
# servers flag missing modules and the like.
Hide
Type "clear && nvim -c 'lua vim.diagnostic.enable(false)' tests/samples/sample.ts" Enter
Sleep 5s
Show

# 1. Editor
Sleep 1s
Screenshot assets/screenshots/editor.png
Sleep 1s

# 2. File picker
Space Space
Sleep 1s
Type "sample"
Sleep 1.5s
Screenshot assets/screenshots/picker.png
Sleep 1s
Escape
Sleep 300ms
Escape
Sleep 500ms

# 3. which-key
Space
Sleep 1.5s
Screenshot assets/screenshots/which-key.png
Sleep 1s
Escape
Sleep 500ms

# 4. Completion menu (Lua: lua_ls completes a standalone file, the TS server
# does not without a tsconfig)
Hide
Type ":e tests/samples/sample.lua" Enter
Sleep 4s
Type "36Gzz"
Show
Sleep 500ms
Type "o"
Type "string.f"
Sleep 3s
Screenshot assets/screenshots/completion.png
Sleep 1s
Escape
Escape
Type "u"
Sleep 1s

Hide
Type ":qa!" Enter
