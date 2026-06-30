#####[ THEMING ]#####
[[ -f "$HOME/.config/mm_theme.zsh" ]] && source "$HOME/.config/mm_theme.zsh"
: "${MM_THEME:=catppuccin-mocha}"   # fallback default if file doesn't exist
source "$HOME/.config/themes.zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Completions
fpath=(~/.docker/completions $fpath)

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

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
{ eval "$(fnm env --use-on-cd --version-file-strategy=recursive)" } > /dev/null 2>&1

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

# delete whole line when pressing cmd + backspace (also needs change in terminal config)
bindkey "^[w" backward-kill-line


# fzf theme (catppuccin-mocha)
export FZF_DEFAULT_OPTS=" \
--color=bg+:$palette[surface0],bg:$palette[base],spinner:$palette[rosewater],hl:$palette[red] \
--color=fg:$palette[text],header:$palette[red],info:$palette[mauve],pointer:$palette[rosewater] \
--color=marker:$palette[lavender],fg+:$palette[text],prompt:$palette[mauve],hl+:$palette[red] \
--color=selected-bg:$palette[surface1] \
--color=border:$palette[overlay0],label:$palette[text]"

# gcloud
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Aliases
source $HOME/Code/dotfiles/aliases.zsh
alias nvim="$HOME/bin/nvim-macos-arm64/bin/nvim"

# Powerlevel10k
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
