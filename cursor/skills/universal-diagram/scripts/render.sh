#!/usr/bin/env bash
# Render a 1920x1080 SVG (or HTML) diagram to PNG using headless Chrome.
# Usage: render.sh input.svg [output.png] [scale]
#   scale defaults to 1 (1920x1080); use 2 for a 3840x2160 retina export.
set -euo pipefail

in="${1:?usage: render.sh input.svg [output.png] [scale]}"
out="${2:-${in%.*}.png}"
scale="${3:-1}"

chrome=""
for c in \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Chromium.app/Contents/MacOS/Chromium" \
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
  "$(command -v google-chrome || true)" "$(command -v chromium || true)"; do
  if [[ -n "$c" && -x "$c" ]]; then chrome="$c"; break; fi
done
[[ -z "$chrome" ]] && { echo "No Chrome/Chromium/Edge found" >&2; exit 1; }

abs_in="$(cd "$(dirname "$in")" && pwd)/$(basename "$in")"
abs_out="$(cd "$(dirname "$out")" && pwd)/$(basename "$out")"
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

if [[ "$abs_in" == *.svg ]]; then
  page="$tmpdir/page.html"
  cat > "$page" <<EOF
<!doctype html><html><head><meta charset="utf-8">
<style>html,body{margin:0;padding:0;background:#fff;overflow:hidden}img{display:block;width:1920px;height:1080px}</style>
</head><body><img src="file://$abs_in"></body></html>
EOF
else
  page="$abs_in"
fi

rm -f "$abs_out"
"$chrome" --headless=new --disable-gpu --hide-scrollbars \
  --force-device-scale-factor="$scale" --window-size=1920,1080 \
  --user-data-dir="$tmpdir/profile" --allow-file-access-from-files \
  --no-first-run --no-default-browser-check \
  --screenshot="$abs_out" "file://$page" >/dev/null 2>&1 &
pid=$!

# Headless Chrome on macOS sometimes lingers after writing the file; stop it ourselves.
for _ in $(seq 1 60); do
  if [[ -s "$abs_out" ]]; then sleep 0.5; break; fi
  kill -0 "$pid" 2>/dev/null || break
  sleep 0.5
done
pkill -P "$pid" 2>/dev/null || true
kill "$pid" 2>/dev/null || true
wait "$pid" 2>/dev/null || true

[[ -s "$abs_out" ]] || { echo "Render failed: no output" >&2; exit 1; }
echo "$abs_out"
