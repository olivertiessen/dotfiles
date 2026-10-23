#!/usr/bin/env bash
# Installs the tools my dotfiles expect (Debian/Ubuntu).
set -euo pipefail

sudo apt update
sudo apt install -y git curl terminator vim fzf ripgrep bat

# Oh My Bash (cloned directly so it doesn't overwrite ~/.bashrc)
[ -d ~/.oh-my-bash ] || git clone --depth 1 https://github.com/ohmybash/oh-my-bash ~/.oh-my-bash

# zoxide (the Ubuntu 22.04 apt package is from 2020, so use the official install script -> ~/.local/bin)
command -v zoxide >/dev/null || curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# JetBrainsMono Nerd Font
fonts=~/.local/share/fonts/JetBrainsMonoNF
if [ ! -d "$fonts" ]; then
  mkdir -p "$fonts"
  curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz | tar -xJ -C "$fonts" --wildcards '*.ttf'
  fc-cache -f
fi


echo "Done. Restart your terminal."
