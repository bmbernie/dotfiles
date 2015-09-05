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
# File  : mac.sh
# OS    : Mac OS X [Tested on Mavericks]
#############################################################################

echo -e "Homebrew: Installing ...\n"
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

echo -e "\nHomebrew: configuring and updating ..."
for brew_commands in "doctor" "update" "upgrade"; do
  brew ${brew_commands}
done

echo -e "\nHomebrew: Installing development tools"
for package in "rlwrap" "readline" "gettext" "coreutils" "bash" "tmux" "vim" "wget" "curl" "python"; do
  echo -e "[Brewing]  -  $package"
  [ `brew ls | grep "$package" -c` == "0" ] && brew install "$package"
done
brew linkapps

# Enable bash 4.0 to be used as a login shell
[ `cat /etc/shells | grep /usr/local/bin/bash -c` == "0" ] && sudo -i 'echo "/usr/local/bin/bash" >> /etc/shells'
chsh -s /usr/local/bin/bash
