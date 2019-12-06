#!/bin/bash

current_user=$(logname) 
echo "Current user: $current_user"
source ./echos.sh

# Fetch submodules
git submodule update --init --recursive

function delete-old(){
    sudo rm -rf "$HOME/$1"  > /dev/null 2>&1
    bot "$HOME/$1 deleted.."
}

function link(){
    ln -sfv "$HOME/dotfiles/$1" "$HOME/$1"  > /dev/null 2>&1

    bot "$HOME/$1 linked to $HOME/dotfiles/$1"
}

FILES=`ls -a | grep -E "^\.\w.*" | grep -v .git`

function link-dot-files {
    #Files to symlink to home directory. Everything starting with '.' except .git*

    for f in $FILES
        do
            running $f
            delete-old $f
        link $f
    done
}

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

function require_brew_cask {
    running "brew $1 $2"
    brew list $1 > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        action "brew cask install $1 $2"
        brew cask install $1 $2
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    fi
    ok
}


function install-brew-packages {
	require_brew blueutil
	require_brew zsh
	require_brew_cask iterm2
	require_brew_cask hammerspoon
	require_brew_cask emacs-plus
}

function install-oh-my-zsh {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s $(which zsh)
}

install-from-git-repo "Vim Vundle"    "https://github.com/VundleVim/Vundle.vim" "$HOME/.vundle"

install-vim-plugins

install-brew
install-brew-packages
install-oh-my-zsh
link-dot-files

ok DONE
