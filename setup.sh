#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/Code/dotfiles"

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
  read -r -p "  Run this step? [y/n/q] " answer
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
    read -r -p "  [r]etry / [s]kip / [q]uit? " choice
    case "$choice" in
      [Rr]) run "$cmd" ;;
      [Qq]) exit 1 ;;
      *)    warn "Skipping after failure." ;;
    esac
  fi
}

# ── Step 0: Clone dotfiles ─────────────────────────────────────────────────────
header "Step 0 — Clone dotfiles"

if [ -d "$DOTFILES" ]; then
  warn "Dotfiles already found at $DOTFILES, skipping clone."
else
  if ask_step "Clone dotfiles repo into ~/Code/dotfiles"; then
    run "mkdir -p ~/Code"
    run "cd ~/Code && git clone git@github.com:MaxMonteil/dotfiles.git"
  fi
fi

# ── MacOS settings ─────────────────────────────────────────────────────────────
header "MacOS"

if ask_step "Remap Caps Lock → Control (opens Keyboard Settings)"; then
  run "open 'x-apple.systempreferences:com.apple.preference.keyboard'"
  echo "  Follow the steps: Keyboard Shortcuts → Modifier Keys → Caps Lock → Control"
  read -r -p "  Press Enter when done..."
fi

# ── MacPorts ───────────────────────────────────────────────────────────────────
header "MacPorts"

if ask_step "Install MacPorts (opens download page — install manually)"; then
  run "open https://www.macports.org/install.php"
  read -r -p "  Press Enter once MacPorts is installed..."
fi

# ── Homebrew ───────────────────────────────────────────────────────────────────
header "Homebrew"

if command -v brew &>/dev/null; then
  warn "Homebrew already installed, skipping."
else
  if ask_step "Install Homebrew"; then
    run '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    run "echo >> ~/.zprofile"
    run "echo 'eval \"\$(/opt/homebrew/bin/brew shellenv zsh)\"' >> ~/.zprofile"
    run 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"'
  fi
fi

# ── Ghostty ────────────────────────────────────────────────────────────────────
header "Ghostty"

if ask_step "Install Ghostty (opens download page — install manually)"; then
  run "open https://ghostty.org/download"
  read -r -p "  Press Enter once Ghostty is installed..."
fi

if ask_step "Symlink Ghostty config"; then
  run "mkdir -p ~/.config"
  if [ -L ~/.config/ghostty ]; then
    warn "~/.config/ghostty symlink already exists, skipping."
  else
    run "ln -s $DOTFILES/ghostty ~/.config/ghostty"
  fi
fi

# ── zsh ────────────────────────────────────────────────────────────────────────
header "zsh — Powerlevel10k"

if [ -d ~/powerlevel10k ]; then
  warn "Powerlevel10k already installed, skipping."
else
  if ask_step "Install Powerlevel10k"; then
    run "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k"
  fi
fi

header "zsh — fzf"

if [ -d ~/.fzf ]; then
  warn "fzf already installed, skipping."
else
  if ask_step "Install fzf"; then
    run "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf"
    info "Running fzf install (answer: y, y, n)"
    ~/.fzf/install --completion --key-bindings --no-update-rc
  fi
fi

header "zsh — Symlinks"

if ask_step "Symlink p10k config (~/.p10k.zsh)"; then
  if [ -L ~/.p10k.zsh ]; then
    warn "~/.p10k.zsh already exists, skipping."
  else
    run "ln -s $DOTFILES/p10k ~/.p10k.zsh"
  fi
fi

if ask_step "Symlink zshrc (~/.zshrc)"; then
  if [ -L ~/.zshrc ]; then
    warn "~/.zshrc already exists, skipping."
  else
    run "ln -s $DOTFILES/zshrc ~/.zshrc"
  fi
fi

if ask_step "Reload shell (exec zsh)"; then
  run "exec zsh"
fi

# ── Neovim ─────────────────────────────────────────────────────────────────────
header "Neovim"

NVIM_VERSION="v0.11.7"
NVIM_TARBALL="nvim-macos-arm64.tar.gz"

if command -v nvim &>/dev/null; then
  warn "Neovim already on PATH, skipping download."
else
  if ask_step "Download and install Neovim $NVIM_VERSION to ~/bin"; then
    run "curl -LO https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/$NVIM_TARBALL"
    run "mkdir -p ~/bin && tar xzf $NVIM_TARBALL -C ~/bin"
    run "rm $NVIM_TARBALL"
  fi
fi

if ask_step "Symlink Neovim config (~/.config/nvim)"; then
  run "mkdir -p ~/.config"
  if [ -L ~/.config/nvim ]; then
    warn "~/.config/nvim already exists, skipping."
  else
    run "ln -s $DOTFILES/nvim ~/.config/nvim"
  fi
fi

# ── fnm ────────────────────────────────────────────────────────────────────────
header "fnm"

if command -v fnm &>/dev/null; then
  warn "fnm already installed, skipping."
else
  if ask_step "Install fnm (Node version manager)"; then
    run "curl -fsSL https://fnm.vercel.app/install | bash"
  fi
fi

# ── Bun ────────────────────────────────────────────────────────────────────────
header "Bun"

if command -v bun &>/dev/null; then
  warn "Bun already installed, skipping."
else
  if ask_step "Install Bun (completions handled via zshrc)"; then
    run "curl -fsSL https://bun.sh/install | bash"
  fi
fi

# ── Done ───────────────────────────────────────────────────────────────────────
echo -e "\n${GREEN}${BOLD}All steps complete!${RESET}"
echo "You may need to restart your terminal for all changes to take effect."
