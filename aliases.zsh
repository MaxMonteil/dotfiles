# shortcut to typing clear all the time
alias c='clear'

# Shortcut for todolist
alias td='todolist'

# common xclip shortcuts
alias iclip="xclip -i -sel clipboard"
alias oclip="xclip -o -sel clipboard"

# always use neovim
alias vi=nvim
alias vim=nvim

# git
alias gst="git status"
alias gco="git checkout"

## Get the default branch name from common branch names or fallback to remote HEAD
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  
  local remote ref
  
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done
  
  # Fallback: try to get the default branch from remote HEAD symbolic refs
  for remote in origin upstream; do
    ref=$(command git rev-parse --abbrev-ref $remote/HEAD 2>/dev/null)
    if [[ $ref == $remote/* ]]; then
      echo ${ref#"$remote/"}; return 0
    fi
  done

  # If no main branch was found, fall back to master but return error
  echo master
  return 1
}
alias gcm="git checkout $(git_main_branch)"

# project shortcuts
alias mylo="cd ~/Code/Mylo"
alias myapp="cd ~/Code/Mylo/packages/app"
alias mysite="cd ~/Code/Mylo/packages/site"
alias blog="cd ~/Code/maxmntl"
alias jwapp="cd ~/Code/jw-app"
