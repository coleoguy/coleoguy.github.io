#!/usr/bin/env bash
# Start Jekyll + click-to-edit server in the background. PIDs go to /tmp/
# so edit-stop.sh can clean them up. Re-running is safe — it kills any
# stale processes first.
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# Gemfile.lock pins bundler 4.0.10, which requires Ruby 3.2+ — the system
# Ruby at /usr/bin/ruby is 2.6 and can't load it. Homebrew has Ruby 4.0.2
# + bundler 4.0.10 installed at /opt/homebrew/opt/ruby/bin but it's not
# symlinked into /opt/homebrew/bin, so prepend it explicitly. If this dir
# doesn't exist, fall through and let the default PATH take over.
if [ -x /opt/homebrew/opt/ruby/bin/bundle ]; then
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
fi

PID_JEKYLL="/tmp/coleoguy-jekyll.pid"
PID_EDIT="/tmp/coleoguy-edit.pid"
LOG_JEKYLL="/tmp/coleoguy-jekyll.log"
LOG_EDIT="/tmp/coleoguy-edit.log"

# ---- Clean up any stale processes from a previous run ---------------------
for f in "$PID_JEKYLL" "$PID_EDIT"; do
  if [ -f "$f" ]; then
    pid="$(cat "$f" 2>/dev/null || echo "")"
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
      kill "$pid" 2>/dev/null || true
    fi
    rm -f "$f"
  fi
done

# Belt-and-suspenders: also kill anything listening on the ports we want.
lsof -tiTCP:4000 -sTCP:LISTEN 2>/dev/null | xargs -r kill 2>/dev/null || true
lsof -tiTCP:4711 -sTCP:LISTEN 2>/dev/null | xargs -r kill 2>/dev/null || true

# ---- Start Jekyll (port 4000) ---------------------------------------------
echo "Starting Jekyll on http://127.0.0.1:4000 ..."
nohup bundle exec jekyll serve --incremental > "$LOG_JEKYLL" 2>&1 &
echo $! > "$PID_JEKYLL"

# ---- Start edit server (port 4711) ----------------------------------------
echo "Starting edit server on http://127.0.0.1:4711 ..."
nohup python3 -m wiki_tools.edit_server > "$LOG_EDIT" 2>&1 &
echo $! > "$PID_EDIT"

# Give them a moment to bind.
sleep 2

# ---- Health check ---------------------------------------------------------
ok_edit=0
ok_jekyll=0
if curl -sf http://127.0.0.1:4711/health > /dev/null 2>&1; then
  ok_edit=1
fi
if curl -sf -o /dev/null -w "%{http_code}" http://127.0.0.1:4000/ 2>/dev/null \
   | grep -qE "^(200|302|304)$"; then
  ok_jekyll=1
fi

if [ "$ok_edit" -eq 1 ]; then
  echo "  ✓ edit server up"
else
  echo "  ✗ edit server not responding — see $LOG_EDIT"
fi
if [ "$ok_jekyll" -eq 1 ]; then
  echo "  ✓ Jekyll up"
else
  echo "  ⚠ Jekyll still building — watch $LOG_JEKYLL; first build can take 10–30s"
fi

cat <<'EOF'

Editing is on. Pick an approach:

  1. Open a page directly with ?edit=1:
       open "http://127.0.0.1:4000/knowledge/topics/sex_chromosome_evolution/?edit=1"

  2. Or visit any page and press ⌘⇧E (macOS) / Ctrl+Shift+E to toggle edit mode.

Green dashed box  = editable (user region). Click and type; ⌘S to save immediately.
Amber dashed box  = Tealc-managed. Click to open a "Propose change" modal;
                    submissions land in data/wiki_proposals/.

Stop with:
  scripts/edit-stop.sh
EOF
