#!/bin/bash


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

install-from-git-repo "Vim Vundle"    "https://github.com/VundleVim/Vundle.vim" "$HOME/.vundle"

install-vim-plugins
echo -e "\n====== All Done!! ======\n"
echo

