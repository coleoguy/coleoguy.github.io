#!/usr/bin/env bash
# Stop the Jekyll, edit-server, and Python-preview processes started by
# edit-start.sh.

PID_JEKYLL="/tmp/coleoguy-jekyll.pid"
PID_EDIT="/tmp/coleoguy-edit.pid"
PID_PREVIEW="/tmp/coleoguy-preview.pid"

stopped_any=0
for spec in "jekyll:$PID_JEKYLL" "edit-server:$PID_EDIT" "preview:$PID_PREVIEW"; do
  name="${spec%%:*}"
  f="${spec##*:}"
  if [ -f "$f" ]; then
    pid="$(cat "$f" 2>/dev/null || echo "")"
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
      kill "$pid" 2>/dev/null && echo "  ✓ stopped $name (PID $pid)"
      stopped_any=1
    fi
    rm -f "$f"
  fi
done

# Belt-and-suspenders: also kill anything still listening on our ports.
for port in 4000 4711 4010; do
  leftover=$(lsof -tiTCP:"$port" -sTCP:LISTEN 2>/dev/null || true)
  if [ -n "$leftover" ]; then
    echo "  ✓ killed leftover process on port $port (PID $leftover)"
    kill $leftover 2>/dev/null || true
    stopped_any=1
  fi
done

if [ "$stopped_any" -eq 0 ]; then
  echo "Nothing to stop — no edit-start.sh processes running."
fi
