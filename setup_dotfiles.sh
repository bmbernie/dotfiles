#!/usr/bin/env bash

#if [[ ! -a ~/.vimrc ]]
#then
#    ln -s ./vim/vimrc ~/.vimrc
#fi

if [[ ! -a ~/.bash_profile ]]
then
    ln -s $HOME/dotfiles/bash/bash_profile ~/.bash_profile
fi

if [[ ! -a ~/.tmux.conf ]]
then
    ln -s $HOME/dotfiles/tmux/tmux.conf ~/.tmux.conf
fi

#source ./vim/setup_vim.sh
#source ./tmux/tmux_setup.sh

