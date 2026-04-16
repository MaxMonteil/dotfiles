# README

Currently rough setup of my important dotfiles and config files.

## Packages

* git
* [MacPorts](https://www.macports.org/install.php)
* [Homebrew](https://docs.brew.sh/)
* [ghostty](https://ghostty.org/download)
* [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#install-and-set-up-zsh-as-default)
    * might already be installed
* [fzf](https://github.com/junegunn/fzf)
* [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
* [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
* [fnm](https://github.com/Schniz/fnm)
* [ni](https://github.com/antfu-collective/ni)
* [Bun](https://bun.sh/docs/installation)

## Step 0

Clone this repo into a folder of your choice, I prefer `~/Code`
1. `mkdir ~/Code`
2. `cd ~/Code`
3. `git clone git@github.com:MaxMonteil/dotfiles.git`

## Automatic Setup

I got AI to write a bash script running through the manual steps below automatically.
It will ask for confirmation before every step and should make setting up a new machine easier.

I haven't used this script yet so user beware!
> It doesn't have any dangerous steps like `rm -rf /` so it should be fine...

### Run the setup script

1. Make the script executable
  a. `chmod +x setup.sh`
2. Run the script then follow the steps
  b. `./setup.sh`

## Manual Setup

### MacOS

Change Caps Lock key to control:
1. Do a global search for "keyboard" to open settings
2. Press "Keyboard Shortcuts..."
3. Select "Modifier Keys" in the left panel
4. Change "Caps Lock key" to Control
5. Hit "Done"

### MacPorts
1. Install [MacPorts](https://www.macports.org/install.php)

### Homebrew
1. Install [Homebrew](https://docs.brew.sh)
  a. `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
  b. `echo >> ~/.zprofile`
  c. `echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile`
  d. `eval "$(/opt/homebrew/bin/brew shellenv zsh)"`

## Ghostty

1. Install [Ghostty](https://ghostty.org/download)
2. Create a symlink to the repo's `ghostty` into the home directory
  a. `mkdir -p ~/.config && ln -s ~/Code/dotfiles/ghostty ~/.config`
3. Reload the config
  a. `cmd+shift+,`

## zsh

1. Install [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
	a. `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k`
2. Install [fzf](https://github.com/junegunn/fzf)
	a. `git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf`
	b. `~/.fzf/install`
		i. Do you want to enable fuzzy auto-completion? ([y]/n) y
		ii. Do you want to enable key bindings? ([y]/n) y
		iii. Do you want to update your shell configuration files? ([y]/n) n
3. Create a symlink to the repo's `p10k.zsh` into the home directory
	a. `ln -s ~/Code/dotfiles/p10k ~/.p10k.zsh`
4. Create a symlink to the repo's `zshrc` into the home directory
	a. `ln -s ~/Code/dotfiles/zshrc ~/.zshrc`
5. Update the shell
	a. `exec zsh`

## Neovim

1. Install [Neovim](https://neovim.io/doc/install/) (v0.11.7)
	a. `curl -LO https://github.com/neovim/neovim/releases/download/v0.11.7/nvim-macos-arm64.tar.gz`
	b. `mkdir -p ~/bin && tar xzf nvim-macos-arm64.tar.gz -C ~/bin`
2. Create a symlink to the repo's nvim config folder
	a. `mkdir -p ~/.config && ln -s ~/Code/dotfiles/nvim ~/.config/nvim`

### LSP

Make sure to reinstall the Mason LSP tools after opening Neovim.

You can find the needed command at the top of:
`dotfiles/nvim/lua/lsp.lua`

## fnm

1. Install [fnm](https://github.com/Schniz/fnm?tab=readme-ov-file#installation) to manage Node versions
  a. `curl -fsSL https://fnm.vercel.app/install | bash`

## ni

Make sure you have Node installed alrady via [[#fnm]].

1. Install [ni](https://github.com/antfu-collective/ni) globally
  a. `npm i -g @antfu/ni`

You'll need to do this after every new version of Node that gets installed.

## Bun

1. Install Bun
  a. `curl -fsSL https://bun.sh/install | bash`
