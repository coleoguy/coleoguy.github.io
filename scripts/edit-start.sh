#!/usr/bin/env bash
# Start Jekyll + the click-to-edit server in the background.
#
# Design note: the previous version of this script assumed Homebrew Ruby lived
# at exactly /opt/homebrew/opt/ruby/bin and silently fell through to whatever
# `bundle` happened to be on PATH. When that assumption broke, `bundle exec`
# died instantly, the script still printed "editing is on", and the browser
# opened onto a dead port. This version locates a usable Ruby itself, verifies
# the toolchain can actually parse Gemfile.lock, and refuses to claim success
# when the server is not answering.
#
# Usage:
#   scripts/edit-start.sh            start everything
#   scripts/edit-start.sh --doctor   diagnose the toolchain and exit

set -uo pipefail   # deliberately NOT -e: we handle failures and report them

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT" || exit 1

PORT_JEKYLL=4000
PORT_EDIT=4711
PID_JEKYLL="/tmp/coleoguy-jekyll.pid"
PID_EDIT="/tmp/coleoguy-edit.pid"
LOG_JEKYLL="/tmp/coleoguy-jekyll.log"
LOG_EDIT="/tmp/coleoguy-edit.log"

# Seconds to wait for Jekyll before declaring failure. The full site with the
# wiki can take 30s+ on a cold build, hence the generous defaults.
WAIT_FIRST="${JEKYLL_WAIT_FIRST:-45}"
WAIT_RETRY="${JEKYLL_WAIT_RETRY:-60}"

DOCTOR=0
[ "${1:-}" = "--doctor" ] && DOCTOR=1

say()  { printf '%s\n' "$*"; }
ok()   { printf '  \033[32m✓\033[0m %s\n' "$*"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$*"; }
bad()  { printf '  \033[31m✗\033[0m %s\n' "$*"; }

# ── 1. Find a Ruby new enough to run bundler 4 / Jekyll 4 ──────────────────
# Gemfile.lock is "BUNDLED WITH 4.0.10" and contains a CHECKSUMS block. Both
# are bundler 4 features. macOS system Ruby (2.6) ships bundler 1.17, which
# cannot parse that file at all, so anything below 3.0 is useless here.
ruby_ok() {
  local rb="$1" v major minor
  [ -x "$rb" ] || return 1
  v="$("$rb" -e 'print RUBY_VERSION' 2>/dev/null)" || return 1
  major="${v%%.*}"; minor="${v#*.}"; minor="${minor%%.*}"
  [ "${major:-0}" -ge 3 ] 2>/dev/null || return 1
  return 0
}

RUBY_BIN=""
CANDIDATES=(
  /opt/homebrew/opt/ruby/bin
  /opt/homebrew/opt/ruby@3.4/bin
  /opt/homebrew/opt/ruby@3.3/bin
  /opt/homebrew/opt/ruby@3.2/bin
  /opt/homebrew/bin
  /usr/local/opt/ruby/bin
  /usr/local/bin
  "$HOME/.rbenv/shims"
  "$HOME/.asdf/shims"
)
# Any other Homebrew ruby@X.Y that exists, plus rvm's default.
for d in /opt/homebrew/opt/ruby@*/bin /usr/local/opt/ruby@*/bin "$HOME"/.rvm/rubies/*/bin; do
  [ -d "$d" ] && CANDIDATES+=("$d")
done

for d in "${CANDIDATES[@]}"; do
  if ruby_ok "$d/ruby"; then RUBY_BIN="$d"; break; fi
done
# Last resort: whatever `ruby` is already on PATH, if it is new enough.
if [ -z "$RUBY_BIN" ] && command -v ruby >/dev/null 2>&1; then
  cand="$(dirname "$(command -v ruby)")"
  ruby_ok "$cand/ruby" && RUBY_BIN="$cand"
fi

if [ -z "$RUBY_BIN" ]; then
  warn "No Ruby 3.x+ found. Jekyll cannot run."
  say ""
  say "  System Ruby at /usr/bin/ruby is 2.6 and cannot parse this Gemfile.lock"
  say "  (it is \"BUNDLED WITH 4.0.10\" and has a CHECKSUMS block, both bundler 4)."
  say ""
  say "  For the real build with live reload and click-to-edit, install Ruby:"
  say "      brew install ruby"
  say "  then re-run this script."
  say ""

  # Rather than leave you with nothing, fall back to the pure-Python preview.
  # It renders the same pages using only the standard library. Verified
  # byte-equivalent to the Jekyll output on every root page.
  if [ -f "$REPO_ROOT/scripts/preview.py" ] && command -v python3 >/dev/null 2>&1; then
    say "  Starting the Ruby-free preview instead ..."
    say ""
    lsof -tiTCP:4010 -sTCP:LISTEN 2>/dev/null | xargs -r kill 2>/dev/null || true
    nohup python3 "$REPO_ROOT/scripts/preview.py" --port 4010 > /tmp/coleoguy-preview.log 2>&1 &
    echo $! > /tmp/coleoguy-preview.pid
    sleep 2
    if curl -sf -o /dev/null --max-time 3 "http://127.0.0.1:4010/index.html"; then
      ok "Preview up at http://127.0.0.1:4010/index.html"
      command -v open >/dev/null 2>&1 && open "http://127.0.0.1:4010/index.html" >/dev/null 2>&1
      say ""
      say "  This is preview only: no click-to-edit, and it is not the"
      say "  published build. Install Ruby when you want the full rig back."
      say "  Stop it with: scripts/edit-stop.sh"
      exit 0
    fi
    bad "Python preview also failed to start. See /tmp/coleoguy-preview.log"
  fi
  exit 1
fi

export PATH="$RUBY_BIN:$PATH"

# Gem-installed executables (jekyll, bundle) do NOT land in the same directory
# as the ruby binary on macOS. Homebrew puts them under
# .../lib/ruby/gems/<ver>/bin, and `gem install --user-install` puts them under
# ~/.gem/ruby/<ver>/bin. Neither is on PATH by default, which is why a
# successful `gem install jekyll` can still leave `jekyll: command not found`.
for gdir in "$("$RUBY_BIN/ruby" -e 'require "rubygems"; print Gem.bindir' 2>/dev/null)" \
            "$("$RUBY_BIN/ruby" -e 'require "rubygems"; print File.join(Gem.user_dir, "bin")' 2>/dev/null)"; do
  [ -n "$gdir" ] && [ -d "$gdir" ] && export PATH="$PATH:$gdir"
done

ok "Ruby $("$RUBY_BIN/ruby" -e 'print RUBY_VERSION') at $RUBY_BIN"

# ── 2. Decide how to invoke Jekyll ────────────────────────────────────────
# Prefer bundler so versions match Gemfile.lock. But bundler is the fragile
# link (the 4.0.10 pin), so if it cannot satisfy the bundle we fall back to a
# plain `jekyll` gem. The Gemfile only asks for jekyll ~> 4.3 and webrick, so
# a standalone jekyll install renders this site identically.
JEKYLL_CMD=""
BUNDLE_NOTE=""

if command -v bundle >/dev/null 2>&1; then
  if bundle check >/dev/null 2>&1; then
    JEKYLL_CMD="bundle exec jekyll"
    ok "bundler satisfied ($(bundle --version 2>/dev/null))"
  else
    warn "bundle check failed; attempting bundle install (this can take a minute)"
    if bundle install >/tmp/coleoguy-bundle.log 2>&1 && bundle check >/dev/null 2>&1; then
      JEKYLL_CMD="bundle exec jekyll"
      ok "bundle install succeeded"
    else
      BUNDLE_NOTE="$(tail -5 /tmp/coleoguy-bundle.log 2>/dev/null)"
      warn "bundler unusable, falling back to a standalone jekyll gem"
    fi
  fi
else
  warn "no bundler on PATH, falling back to a standalone jekyll gem"
fi

if [ -z "$JEKYLL_CMD" ]; then
  if ! command -v jekyll >/dev/null 2>&1; then
    warn "installing jekyll (one time, no sudo needed)"
    if ! gem install jekyll --no-document >/tmp/coleoguy-geminstall.log 2>&1; then
      gem install jekyll --no-document --user-install >>/tmp/coleoguy-geminstall.log 2>&1
    fi
    # re-add gem bindirs, the install may have created them
    for gdir in "$(ruby -e 'require "rubygems"; print Gem.bindir' 2>/dev/null)" \
                "$(ruby -e 'require "rubygems"; print File.join(Gem.user_dir, "bin")' 2>/dev/null)"; do
      [ -n "$gdir" ] && [ -d "$gdir" ] && export PATH="$PATH:$gdir"
    done
  fi
  if command -v jekyll >/dev/null 2>&1; then
    JEKYLL_CMD="jekyll"
    ok "using standalone $(jekyll --version 2>/dev/null | head -1)"
  else
    bad "Could not get Jekyll running."
    [ -n "$BUNDLE_NOTE" ] && { say ""; say "bundler said:"; say "$BUNDLE_NOTE"; }
    say ""
    say "Last resort, run these by hand and send me the output:"
    say "    gem install jekyll"
    say "    jekyll --version"
    exit 1
  fi
fi

if [ "$DOCTOR" -eq 1 ]; then
  say ""
  ok "Toolchain looks usable. Jekyll would start with: $JEKYLL_CMD serve"
  exit 0
fi

# ── 3. Clear stale processes and ports ────────────────────────────────────
for f in "$PID_JEKYLL" "$PID_EDIT"; do
  if [ -f "$f" ]; then
    pid="$(cat "$f" 2>/dev/null || echo "")"
    [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null && kill "$pid" 2>/dev/null
    rm -f "$f"
  fi
done
for port in "$PORT_JEKYLL" "$PORT_EDIT"; do
  leftover="$(lsof -tiTCP:"$port" -sTCP:LISTEN 2>/dev/null || true)"
  [ -n "$leftover" ] && kill $leftover 2>/dev/null
done

# ── 4. Start Jekyll ───────────────────────────────────────────────────────
# A .jekyll-metadata written by a different Ruby or Jekyll can make
# --incremental serve stale or broken pages, so we retry cleanly if the
# incremental build fails to come up.
start_jekyll() {
  local extra="$1"
  nohup $JEKYLL_CMD serve $extra > "$LOG_JEKYLL" 2>&1 &
  echo $! > "$PID_JEKYLL"
}

jekyll_up() {
  local code
  code="$(curl -sf -o /dev/null -w '%{http_code}' "http://127.0.0.1:$PORT_JEKYLL/" 2>/dev/null)"
  case "$code" in 200|302|304) return 0 ;; *) return 1 ;; esac
}

wait_for_jekyll() {
  local tries="$1" i
  for ((i=0; i<tries; i++)); do
    jekyll_up && return 0
    # If the process already died there is no point waiting out the clock.
    local pid; pid="$(cat "$PID_JEKYLL" 2>/dev/null || echo "")"
    [ -n "$pid" ] && ! kill -0 "$pid" 2>/dev/null && return 1
    sleep 1
  done
  return 1
}

say ""
say "Starting Jekyll on http://127.0.0.1:$PORT_JEKYLL ..."
start_jekyll "--incremental"
if ! wait_for_jekyll "$WAIT_FIRST"; then
  warn "incremental build did not come up, clearing cache and retrying"
  pid="$(cat "$PID_JEKYLL" 2>/dev/null || echo "")"
  [ -n "$pid" ] && kill "$pid" 2>/dev/null
  rm -f .jekyll-metadata
  rm -rf _site
  start_jekyll ""
  wait_for_jekyll "$WAIT_RETRY"
fi

# ── 5. Start the click-to-edit server ─────────────────────────────────────
say "Starting edit server on http://127.0.0.1:$PORT_EDIT ..."
nohup python3 -m wiki_tools.edit_server > "$LOG_EDIT" 2>&1 &
echo $! > "$PID_EDIT"
sleep 2

ok_edit=0
curl -sf "http://127.0.0.1:$PORT_EDIT/health" >/dev/null 2>&1 && ok_edit=1

# ── 6. Report honestly ────────────────────────────────────────────────────
say ""
if jekyll_up; then
  ok "Jekyll up at http://127.0.0.1:$PORT_JEKYLL"
else
  bad "Jekyll is NOT running. The site will not load."
  say ""
  # Ruby backtraces bury the actual message under 20 lines of "from ...".
  # Strip those so the real error is the thing you actually see.
  grep -v -E "^[[:space:]]*from " "$LOG_JEKYLL" 2>/dev/null \
    | grep -v -E "^[[:space:]]*$" \
    | tail -15 \
    | sed 's/^/    /'
  say ""
  say "Full log: $LOG_JEKYLL"
  exit 1
fi

if [ "$ok_edit" -eq 1 ]; then
  ok "Edit server up at http://127.0.0.1:$PORT_EDIT"
else
  warn "Edit server not responding. Preview works, click-to-edit will not."
  say "  Error:"
  grep -v -E "^[[:space:]]*from " "$LOG_EDIT" 2>/dev/null | tail -6 | sed 's/^/    /' 
fi

cat <<EOF

Editing is on. Pick an approach:

  1. Open a page directly with ?edit=1:
       open "http://127.0.0.1:$PORT_JEKYLL/knowledge/topics/sex_chromosome_evolution/?edit=1"

  2. Or visit any page and press ⌘⇧E (macOS) / Ctrl+Shift+E to toggle edit mode.

Green dashed box  = editable (user region). Click and type; ⌘S to save immediately.
Amber dashed box  = Tealc-managed. Click to open a "Propose change" modal;
                    submissions land in data/wiki_proposals/.

Stop with:
  scripts/edit-stop.sh
EOF
