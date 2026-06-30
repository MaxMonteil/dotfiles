#!/usr/bin/env zsh

set -euo pipefail

DOTFILES="$HOME/Code/dotfiles"
AUTHOR_NAME="Maximilien Monteil"
AUTHOR_EMAIL="maximilienmonteil@gmail.com"

source "$DOTFILES/scripts/utils.zsh"

# ── Step 0: Clone dotfiles ────────────────────────────────────────────────────
header "Step 0 — Clone dotfiles"

if [[ -d "$DOTFILES" ]]; then
  warn "Dotfiles already found at $DOTFILES, skipping clone."
else
  if ask_step "Clone dotfiles repo into ~/Code/dotfiles"; then
    run "mkdir -p ~/Code"
    run "cd ~/Code && git clone git@github.com:MaxMonteil/dotfiles.git"
  fi
fi

# ── Git global settings ───────────────────────────────────────────────────────
header "Git"

if ask_step "Set global git settings?"; then
  git config --global user.name "$AUTHOR_NAME"
  git config --global user.email "$AUTHOR_EMAIL"
  git config --global push.autoSetupRemote true
  success "Git config updated."
fi

# ── MacOS settings ────────────────────────────────────────────────────────────
header "MacOS"

if ask_step "Remap Caps Lock → Control (opens Keyboard Settings)"; then
  run "open 'x-apple.systempreferences:com.apple.preference.keyboard'"
  echo "  Follow the steps: Keyboard Shortcuts → Modifier Keys → Caps Lock → Control"
  read -r -p "  Press Enter when done..."
fi

# ── MacPorts ──────────────────────────────────────────────────────────────────
header "MacPorts"

if ask_step "Install MacPorts (opens download page — install manually)"; then
  run "open https://www.macports.org/install.php"
  read -r -p "  Press Enter once MacPorts is installed..."

  # Refresh PATH so port/rg etc. are found without restarting the shell
  if [[ -d /opt/local/bin ]]; then
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    success "PATH updated to include MacPorts binaries."
  fi
fi

# ── Homebrew ──────────────────────────────────────────────────────────────────
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

# ── Ghostty ───────────────────────────────────────────────────────────────────
header "Ghostty"

if ask_step "Install Ghostty (opens download page — install manually)"; then
  run "open https://ghostty.org/download"
  read -r -p "  Press Enter once Ghostty is installed..."
fi

if ask_step "Symlink Ghostty config"; then
  run "mkdir -p ~/.config/ghostty"
  if [[ -L ~/.config/ghostty ]]; then
    warn "~/.config/ghostty symlink already exists, skipping."
  else
    run "ln -s $DOTFILES/ghostty/config.ghostty ~/.config/ghostty/config.ghostty"
  fi
fi

# ── zsh ───────────────────────────────────────────────────────────────────────
header "zsh — Powerlevel10k"

if [[ -d ~/powerlevel10k ]]; then
  warn "Powerlevel10k already installed, skipping."
else
  if ask_step "Install Powerlevel10k"; then
    run "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k"
  fi
fi

header "zsh — fzf"

if [[ -d ~/.fzf ]]; then
  warn "fzf already installed, skipping."
else
  if ask_step "Install fzf"; then
    run "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf"
    info "Running fzf install (answer: y, y, n)"
    ~/.fzf/install --completion --key-bindings --no-update-rc
  fi
fi

header "zsh — ripgrep"

if command -v rg &>/dev/null; then
  warn "ripgrep already installed, skipping."
else
  if ask_step "Install ripgrep via MacPorts"; then
    run "sudo port install ripgrep"
  fi
fi

# ── Theme selection ───────────────────────────────────────────────────────────
header "Theme"

if ask_step "Select theme"; then
  echo "  Available themes:"
  echo "    1) Catppuccin Frappe"
  echo "    2) Catppuccin Latte"
  echo "    3) Catppuccin Macchiato"
  echo "    4) Catppuccin Mocha"
  read -r -p "  Choose [1-4]: " theme_choice

  case "$theme_choice" in
    1) MM_THEME="catppuccin-frappe"; GHOSTTY_THEME="Catppuccin Frappe" ;;
    2) MM_THEME="catppuccin-latte"; GHOSTTY_THEME="Catppuccin Latte" ;;
    3) MM_THEME="catppuccin-macchiato"; GHOSTTY_THEME="Catppuccin Macchiato" ;;
    4) MM_THEME="catppuccin-mocha"; GHOSTTY_THEME="Catppuccin Mocha" ;;
    *) warn "Invalid choice, defaulting to catppuccin-mocha"
       MM_THEME="catppuccin-mocha"; GHOSTTY_THEME="Catppuccin Mocha" ;;
  esac

  mkdir -p ~/.config
  echo "export MM_THEME=\"$MM_THEME\"" > ~/.config/mm_theme.zsh
  success "Theme set to $MM_THEME (saved to ~/.config/mm_theme.zsh)"

  mkdir -p ~/.config/ghostty
  echo "theme = $GHOSTTY_THEME" > ~/.config/ghostty/theme.conf
  success "Ghostty theme set to $GHOSTTY_THEME (saved to ~/.config/ghostty/theme.conf)"
fi

if ask_step "Setup helper to change theme"; then
  if [[ -L ~/bin/retheme ]]; then
    warn "~/bin/retheme already exists, skipping."
  else
    run "ln -s $DOTFILES/scripts/rethemes.sh ~/bin/retheme"
  fi
fi

# ── Symlinks ──────────────────────────────────────────────────────────────────
header "Symlinks"

if ask_step "Symlink themes (~/.config/themes.zsh)"; then
  if [[ -L ~/.config/themes.zsh ]]; then
    warn "~/.config/themes.zsh already exists, skipping."
  else
    run "ln -s $DOTFILES/themes.zsh ~/.config/themes.zsh"
  fi
fi

if ask_step "Symlink p10k config (~/.p10k.zsh)"; then
  if [[ -L ~/.p10k.zsh ]]; then
    warn "~/.p10k.zsh already exists, skipping."
  else
    run "ln -s $DOTFILES/p10k.zsh ~/.p10k.zsh"
  fi
fi

if ask_step "Symlink zshrc (~/.zshrc)"; then
  if [[ -L ~/.zshrc ]]; then
    warn "~/.zshrc already exists, skipping."
  else
    run "ln -s $DOTFILES/zshrc ~/.zshrc"
  fi
fi

if ask_step "Apply shell config (source ~/.zshrc)"; then
  if [[ -L ~/.zshrc ]]; then
    if [[ ! source ~/.zshrc ]]; then
      warn "Some part of .zshrc failed to load."
    else
      success "Shell config applied."
    fi
  fi
fi

# ── Neovim ────────────────────────────────────────────────────────────────────
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
  if [[ -L ~/.config/nvim ]]; then
    warn "~/.config/nvim already exists, skipping."
  else
    run "ln -s $DOTFILES/nvim ~/.config/nvim"
  fi
fi

# ── fnm ───────────────────────────────────────────────────────────────────────
header "fnm"

if command -v fnm &>/dev/null; then
  warn "fnm already installed, skipping."
else
  if ask_step "Install fnm (Node version manager)"; then
    run "curl -fsSL https://fnm.vercel.app/install | bash"

    # Load fnm into current shell so we can use it immediately
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --use-on-cd --shell zsh)"
  fi
fi

if command -v fnm &>/dev/null; then
  if ask_step "Install Node LTS and set as default"; then
    run "fnm install --lts"
    run "fnm default lts-latest"
    success "Node LTS installed and set as default."
  fi
fi

# ── Bun ───────────────────────────────────────────────────────────────────────
header "Bun"

if command -v bun &>/dev/null; then
  warn "Bun already installed, skipping."
else
  if ask_step "Install Bun (completions handled via zshrc)"; then
    run "curl -fsSL https://bun.sh/install | bash"
  fi
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo -e "\n${GREEN}${BOLD}All steps complete!${RESET}"
echo "You may need to restart your terminal for all changes to take effect."
