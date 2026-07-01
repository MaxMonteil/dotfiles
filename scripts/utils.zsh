#!/usr/bin/env zsh

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Helpers ───────────────────────────────────────────────────────────────────
info()    { echo -e "${BLUE}▶${RESET} $*"; }
success() { echo -e "${GREEN}✔${RESET} $*"; }
warn()    { echo -e "${YELLOW}⚠${RESET} $*"; }
error()   { echo -e "${RED}✖${RESET} $*"; }
header()  { echo -e "\n${BOLD}━━━ $* ━━━${RESET}"; }

# Ask user before running a step. Returns 0 to run, 1 to skip.
ask_step() {
  local desc="$1"
  echo -e "\n${BOLD}Step:${RESET} $desc"
  read "answer?  Run this step? [y/n/q] "
  case "$answer" in
    [Yy]) return 0 ;;
    [Qq]) echo "Quitting."; exit 0 ;;
    *)    warn "Skipping."; return 1 ;;
  esac
}

# Run a command, and on failure ask user what to do.
run() {
  local cmd="$*"
  info "Running: $cmd"
  if eval "$cmd"; then
    success "Done."
  else
    error "Command failed: $cmd"
    read "choice?  [r]etry / [s]kip / [q]uit? "
    case "$choice" in
      [Rr]) run "$cmd" ;;
      [Qq]) exit 1 ;;
      *)    warn "Skipping after failure." ;;
    esac
  fi
}
