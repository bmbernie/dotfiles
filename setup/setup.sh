#!/usr/bin/env bash
#
# The MIT License (MIT)
#
# Copyright (c) 2013 bmbernie
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#############################################################################
# Author: Brandon Bernie
# Email : bmbernie@gmail.com
# File  : setup.sh
# OS    : Mac OS X && GNU/Linux [Tested on Mavericks &&  Ubuntu 12.04.3 LTS]
# What  : set up development environment for Node.js for osx and linux
#############################################################################

LNFLAGS=""

#############################################################################
# Mac OS X 10.9 - specific
#############################################################################
if [ $(uname) == "Darwin" ]; then
  sudo -v
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
  source mac.sh
fi

#############################################################################
# Ubuntu 12.04 LTS EC2 instance - specific
#############################################################################
if [ $(uname) == "Linux" ]; then
  LNFLAGS="b"
  source linux.sh
fi

#############################################################################
# All Systems
#############################################################################

#############################################################################
# DOTFILES - PERSONAL ENVIRONMENT
#############################################################################
cd $HOME

# if ~/.dotfiles exists back it up
if [ -d $HOME/.dotfiles/ ]; then
  mv $HOME/.dotfiles $HOME/.dotfiles.old
fi

# clone repo
git clone https://github.com/bmbernie/dotfiles.git $HOME/.dotfiles

# if everything worked then go inside dir and get dependencies
if [ -d $HOME/.dotfiles/ ]; then
  cd $HOME/.dotfiles
  
  if [ -d $HOME/.dotfiles/dircolors-solarized/ ]; then
    rm -rf $HOME/.dotfiles/dircolors-solarized
  fi
  git clone https://github.com/seebi/dircolors-solarized.git $HOME/.dotfiles/dircolors-solarized
  
  if [ -d $HOME/dotfiles/solarized/ ]; then
    rm -rf $HOME/dotfiles/solarized 
  fi
  git clone git://github.com/altercation/solarized.git $HOME/.dotfiles/solarized
  
  cd $HOME
fi

f [ $(uname) == "Darwin" ]; then
  ln -s $HOME/.dotfiles/.bash_profile $HOME/.bash_profile
fi

if [ $(uname) == "Linux" ]; then
  rm $HOME/.bashrc
  ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
fi

ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
