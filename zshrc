#!/bin/zsh

# Completions
fpath=(~/.docker/completions $fpath)

autoload -Uz compinit; compinit

# Completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Options
setopt AUTO_CD
setopt NO_CASE_GLOB
setopt EXTENDED_HISTORY

# History
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST 
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=$HISTSIZE

# Correction
setopt CORRECT
setopt CORRECT_ALL

# fnm
export PATH="/home/$USER/.fnm:$PATH"
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fzf
if [[ ! "$PATH" == */.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

source <(fzf --zsh)

# Keybindings
# Bind up and down arrow to match history with what's already written
# needs to come after fzf binding
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# delete whole line when pressing cmd + backspace (also needs ghostty change)
bindkey "^[w" backward-kill-line


# fzf theme (catppuccin-mocha)
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

# gcloud
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Aliases
source $HOME/Code/dotfiles/aliases.zsh
alias nvim="$HOME/bin/nvim-macos-arm64/bin/nvim"

# starship
eval "$(starship init zsh)"
