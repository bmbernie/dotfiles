#!/usr/bin/env bash

if [[ ! -a ~/.vimrc ]]
then
  mkdir -p $HOME/.vim/
  mkdir -p $HOME/.vim/bundle
  cp -a $HOME/dotfiles/vim/bundle/YouCompleteMe $HOME/.vim/bundle/YouCompleteMe
  git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
  cp $HOME/dotfiles/vim/vimrc $HOME/.vim/vimrc
  ln -s $HOME/.vim/vimrc $HOME/.vimrc
fi

if [[ ! -a ~/.bash_profile ]]
then
  ln -s $HOME/dotfiles/bash/bash_profile ~/.bash_profile
fi

if [[ ! -a ~/.tmux.conf ]]
then
  ln -s $HOME/dotfiles/tmux/tmux.conf ~/.tmux.conf
fi
