# README

<!--toc:start-->
- [Step 0](#step-0)
  - [Git](#git)
- [Automatic Setup](#automatic-setup)
  - [Run the setup script](#run-the-setup-script)
- [Manual Setup](#manual-setup)
  - [MacOS](#macos)
  - [MacPorts](#macports)
  - [Homebrew](#homebrew)
- [Ghostty](#ghostty)
- [zsh](#zsh)
  - [Powerlevel10k](#powerlevel10k)
  - [fzf](#fzf)
  - [ripgrep](#ripgrep)
  - [Symlinks](#symlinks)
- [Neovim](#neovim)
  - [LSP](#lsp)
- [fnm](#fnm)
- [ni](#ni)
- [Bun](#bun)
<!--toc:end-->

Currently rough setup of my important dotfiles and config files.

## Step 0

Make sure `git` is installed.

Clone this repo into a folder of your choice, I prefer `~/Code`

```bash
mkdir ~/Code`
cd ~/Code
git clone git@github.com:MaxMonteil/dotfiles.git
```

### Git

Don't forget to update your git username and email:

```bash
git config --global user.name "Maximilien Monteil"
git config --global user.email "maximilienmonteil@gmail.com"
```

I also like to auto set the upstream:

```bash
git config --global push.autoSetupRemote true
```

## Automatic Setup

I got AI to write a bash script running through the manual steps below automatically.

It will ask for confirmation before every step and should make setting up a new machine easier.

I haven't used this script yet so user beware!

> It doesn't have any dangerous steps like `rm -rf /` so it should be fine...

### Run the setup script

Make the script executable then run it.

```bash
chmod +x setup.sh
./setup.sh
```

## Manual Setup

### MacOS

Change Caps Lock key to control:
1. Do a global search for "keyboard" to open settings
2. Press "Keyboard Shortcuts..."
3. Select "Modifier Keys" in the left panel
4. Change "Caps Lock key" to Control
5. Hit "Done"

### MacPorts

I prefer to use [MacPorts](https://www.macports.org/install.php) when possible, no real reason tbh.

Install [MacPorts](https://www.macports.org/install.php)

### Homebrew

Some packages are only on [Homebrew](https://docs.brew.sh/) though and some installers below depend on it.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
```

### Ghostty

My preferred terminal emulator, it rocks!

Install [Ghostty](https://ghostty.org/download)

```bash
# Create a symlink to the repo's `ghostty` into the home directory
mkdir -p ~/.config
ln -s ~/Code/dotfiles/ghostty ~/.config
```

Next, open ghostty and restart the terminal:

`cmd+shift+,`

### zsh

#### Powerlevel10k

Honestly [Powerlevel10k](https://github.com/romkatv/powerlevel10k) is the fastest terminal prompt I've ever seen (yes faster than starship.rs when it comes to git).

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

#### fzf

[fzf](https://github.com/junegunn/fzf) is the fuzzy searcher of excellence.

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
# Do you want to enable fuzzy auto-completion? ([y]/n) y
# Do you want to enable key bindings? ([y]/n) y
# Do you want to update your shell configuration files? ([y]/n) n
```

#### ripgrep

I rarely use [ripgrep](https://github.com/burntsushi/ripgrep) in the terminal directly, but it's core to the nvim search plugin I have.

```bash
sudo port install ripgrep
```

### Symlinks

```bash
# Create a symlink to the repo's `p10k.zsh` into the home directory
ln -s ~/Code/dotfiles/p10k ~/.p10k.zsh

# Create a symlink to the repo's `zshrc` into the home directory
ln -s ~/Code/dotfiles/zshrc ~/.zshrc
```

Then reload the shell to apply all changes.

```bash
exec zsh
```

### Neovim

Started with vim to be cool, switch to [Neovim](https://github.com/neovim/neovim) to be cooler, never looked back.

```bash
# Install Neovim v0.11.7
curl -LO https://github.com/neovim/neovim/releases/download/v0.11.7/nvim-macos-arm64.tar.gz
mkdir -p ~/bin
tar xzf nvim-macos-arm64.tar.gz -C ~/bin

# Create a symlink to the repo's nvim config folder
mkdir -p ~/.config
ln -s ~/Code/dotfiles/nvim ~/.config/nvim
```

#### LSP

Make sure to reinstall the Mason LSP tools after opening Neovim.

You can find the needed command at the top of:
`dotfiles/nvim/lua/lsp.lua`

### fnm

`nvm` is dead, long live `nvm`!

[fnm](https://github.com/Schniz/fnm) does essentially the same thing but Rust.

My preferred way to manage Node versions.

```bash
curl -fsSL https://fnm.vercel.app/install | bash
```

### ni

I use [ni](https://github.com/antfu-collective/ni) to not have to deal with different node installers in different projects (npm, pnpm, yarn). Having one command in all projects is a muscle-memory saver.

Make sure you have Node installed alrady via [fnm](#fnm).

```bash
npm i -g @antfu/ni
```

> [!NOTE]
> You'll need to do this after every new version of Node that gets installed.

### Bun

I mostly use [Bun](https://bun.sh/docs/installation) to write quick scripts in Typescript.

```bash
curl -fsSL https://bun.sh/install | bash
```
