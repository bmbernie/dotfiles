#!/usr/bin/env bash

if [ $(uname) == "Darwin" ]; then
  ln -s $HOME/.dotfiles/.bash_profile $HOME/.bash_profile
fi

if [ $(uname) == "Linux" ]; then
  rm $HOME/.bashrc
  ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
fi

ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
