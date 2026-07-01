#!/usr/bin/env zsh

set -euo pipefail

DOTFILES="$HOME/Code/dotfiles"

source "$DOTFILES/scripts/utils.zsh"

# ── Theme selection ───────────────────────────────────────────────────────────
echo "  Available themes:"
echo "    1) Catppuccin Frappe"
echo "    2) Catppuccin Latte"
echo "    3) Catppuccin Macchiato"
echo "    4) Catppuccin Mocha"
read "theme_choice?  Choose [1-4]: "

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

info "Reload the Ghostty config for the theme to take effect. (⇧ ⌘ ,)"
