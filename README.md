Dotfiles for zsh on multiple OSes
=================================

These are my dotfiles, based on Holman's (https://github.com/holman/dotfiles)

## Installation

```sh
git clone https://github.com/matthull/dotfiles ~/code/dotfiles
cd ~/code/dotfiles
source install
```

## Reloading
After changing any dotfiles, run the following to reload all scripts and run all installers.

```sh
rld
```

## Editing
- .symlink: Files with this extension are symlinked to home folder
- .strap: Installer scripts which should be setup to run only if component is not already installed
