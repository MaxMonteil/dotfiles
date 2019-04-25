# shortcut to typing clear all the time
alias c='clear'

# quickly get to hdd
alias hdd='cd /mnt/HDD/Documents/Programming'

# Common update commands
alias update='sudo apt update && sudo apt upgrade -y'

# Open files from terminal with default file
alias o='xdg-open 2>/dev/null'

# Shortcut for todolist
alias td='todolist'

# common xclip shortcuts
alias iclip="xclip -i -sel clipboard"
alias oclip="xclip -o -sel clipboard"

# pipenv aliases
alias prp='pipenv run python -q'

# TMUX setup scripts
alias pymux='~/.tmux-scripts/pymux.sh'

# Alias to Spotify control script
alias sp='~/bin/sp.sh'

# Launch journal with templates
alias jrnlm='jrnl < /mnt/HDD/Documents/journal/daily_template.txt && jrnl -1 --edit'
alias jrnle='jrnl -on today --edit'
function exportJrnl () { jrnl --export markdown | pandoc -s -o "$1"; }

# Function to create a new project directory with commands I always run
function mkpro () {
  echo "Creating project...";
  mkcd "$PWD/$1";
  echo "Creating git repository...";
  git init;
  echo "Adding .gitignore...";
  cp ~/.new_project_config/gitignore ./.gitignore;
  echo "Creating README...";
  echo "# ${1//_/ }" > README.md;
  cat ~/.new_project_config/readme_template.md >> $PWD/README.md;
  echo -e "Done!\n";
  ls -a;
}
