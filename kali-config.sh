#!/usr/bin/env bash

echo "setting up vim"
cd $HOME
git clone https://github.com/bmbernie/.vim .vim
cd .vim
./install.sh
cd $HOME
git clone https://github.com/bmbernie/dotfiles .dotfiles
cd .dotfiles
./install.sh

apt-get clean && apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
apt-get install build-essential
apt-get autoremove -y
