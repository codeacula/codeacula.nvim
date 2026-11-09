#!/usr/bin/env bash
# Render tests/samples/* through the real nvim config and capture each one as a
# PNG in assets/screenshots/, for the README.
#
# Needs: nvim (with treesitter parsers for the samples), chromium, magick.
# Usage: scripts/screenshots.sh [sample ...]   e.g. scripts/screenshots.sh sample.lua
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
out="$root/assets/screenshots"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
mkdir -p "$out"

font="${CODEACULA_SHOT_FONT:-JetBrainsMono Nerd Font}"
bg="$(nvim --headless -c 'lua io.write(require("codeacula.palette").navy_950 or "")' -c 'qa!' 2>/dev/null || true)"
bg="${bg:-#0c1220}"

if [ $# -gt 0 ]; then
  samples=("$@")
else
  samples=(sample.lua sample.ts sample.rs sample.cs)
fi

for name in "${samples[@]}"; do
  src="$root/tests/samples/$name"
  html="$work/$name.html"
  png="$out/${name#sample.}.png"

  CODEACULA_HTML_OUT="$html" nvim --headless "$src" \
    -c "colorscheme codeacula" \
    -c "lua vim.treesitter.start()" \
    -c "luafile $root/tests/tohtml.lua" \
    -c "qa!" 2>/dev/null

  # Swap tohtml's default font stack for a real coding font and add padding.
  sed -i "s#</style>#* {font-family: \"$font\", monospace !important; font-variant-ligatures: none}\
 body {margin: 0; padding: 28px 36px; font-size: 15px; line-height: 1.45}\
 pre {margin: 0}\
</style>#" "$html"

  chromium --headless --disable-gpu --hide-scrollbars --force-device-scale-factor=2 \
    --window-size=1600,1700 --screenshot="$work/raw.png" "file://$html" >/dev/null 2>&1

  # Crop to the code, then add an even border in the theme's background colour.
  magick "$work/raw.png" -fuzz 1% -trim +repage \
    -bordercolor "$bg" -border 56 "$png"
  echo "wrote ${png#"$root"/}"
done
