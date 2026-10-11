#!/usr/bin/env bash
# Render tests/samples/* to build/review/*.html with the real nvim config, so
# treesitter parsers and plugins are active.
set -uo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
out="$root/build/review"
mkdir -p "$out"
status=0
for f in "$root"/tests/samples/*; do
  name="$(basename "$f")"
  if ! CODEACULA_HTML_OUT="$out/$name.html" nvim --headless "$f" \
    -c "colorscheme codeacula" \
    -c "lua vim.treesitter.start()" \
    -c "luafile $root/tests/tohtml.lua" \
    -c "qa!" 2>"$out/$name.err" || [ ! -s "$out/$name.html" ]; then
    echo "render failed: $name (see $out/$name.err)" >&2
    status=1
  else
    rm -f "$out/$name.err"
  fi
done
ls "$out"
exit $status
