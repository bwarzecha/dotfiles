#!/bin/bash

source ./echos.sh

#==============
# Remove old dot flies
#==============
sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1
sudo rm -rf ~/.bashrc > /dev/null 2>&1
sudo rm -rf ~/.bash_profile > /dev/null 2>&1
sudo rm -rf ~/.aliases > /dev/null 2>&1
sudo rm -rf ~/.exports > /dev/null 2>&1
sudo rm -rf ~/.functions > /dev/null 2>&1
sudo rm -rf ~/.hammerspoon > /dev/null 2>&1


ln -sfv ~/dotfiles/.vim ~/.vim
ln -sfv ~/dotfiles/.vimrc ~/.vimrc
ln -sfv ~/dotfiles/.bashrc ~/.bashrc
ln -sfv ~/dotfiles/.bash_profile ~/.bash_profile
ln -sfv ~/dotfiles/.aliases ~/.aliases
ln -sfv ~/dotfiles/.exports ~/.exports
ln -sfv ~/dotfiles/.functions ~/.functions
ln -sfv ~/dotfiles/.hammerspoon ~/.hammerspoon

function install-vim-plugins {
    echo "Installing Vim plugins..."
    vim +PluginInstall +qall
}

function install-from-git-repo {
    local -r name="$1"
    local -r repo="$2"
    local -r dest="$3"

    echo "Installing $name..."
    if [ -d "$dest" ]; then
      (cd "$dest" && git pull --progress)
    else
      rm -rf "$dest"
      git clone --progress "$repo" "$dest"
    fi
}

function install-brew {
	command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; \
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }
}

function require_brew {
    running "brew $1 $2"
    brew list $1 > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        action "brew install $1 $2"
        brew install $1 $2
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    fi
    ok
}

function install-brew-packages {
	require_brew blueutil
}

install-from-git-repo "Vim Vundle"    "https://github.com/VundleVim/Vundle.vim" "$HOME/.vundle"

install-vim-plugins

install-brew
install-brew-packages

echo -e "\n====== All Done!! ======\n"
echo



