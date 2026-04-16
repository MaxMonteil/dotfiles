# README

Currently rough setup of my important dotfiles and config files.

## Setup

### Packages

#### Mac OS

* [macports](https://ports.macports.org/)

#### Shell

* [ghostty](https://ghostty.org/download)
* [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#install-and-set-up-zsh-as-default)
    * might already be installed
* [oh my zsh](https://ohmyz.sh/)
* [powerlevel10k](https://github.com/romkatv/powerlevel10k)

* git
* [MacPorts](https://www.macports.org/install.php)
* [Homebrew](https://docs.brew.sh/)
* [fnm](https://github.com/Schniz/fnm)
* [Node](https://nodejs.org/en/download)
* [Bun](https://bun.sh/docs/installation)
* [ni](https://github.com/antfu-collective/ni)
* [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
    * [vim-plug](https://github.com/junegunn/vim-plug)
* [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
* [fzf](https://github.com/junegunn/fzf)

### Authentication

1. Setup git SSH with github

## Laptop Setup

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
4. Create a symlink to the repo's `zshrc` into the home directory
	a. `ln -s <path-to-git-repo>/dotfiles/zshrc ~/.zshrc`
5. Update the shell
	a. `exec zsh`

## Neovim

1. Install [Neovim](https://neovim.io/doc/install/) (v0.11.7)
	a. `curl -LO https://github.com/neovim/neovim/releases/download/v0.11.7/nvim-macos-arm64.tar.gz`
	b. `mkdir -p ~/bin && tar xzf nvim-macos-arm64.tar.gz -C ~/bin`
3. Create a symlink to the repo's nvim config folder
	a. `mkdir -p ~/.config && ln -s <path-to-git-repo>/dotfiles/nvim ~/.config/nvim`

## Development

### fnm

1. Install [fnm](https://github.com/Schniz/fnm?tab=readme-ov-file#installation) to manage Node versions
  a. `curl -fsSL https://fnm.vercel.app/install | bash`

### Node

Ideally use fnm to install the version of Node you want.

### ni

1. Install [ni](https://github.com/antfu-collective/ni) globally
  a. `npm i -g @antfu/ni`
