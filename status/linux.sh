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
# File  : linux.sh
# OS    : GNU/Linux -  [ Tested on Ubuntu 12.04.3 LTS ]
# What  : Linux specific software installation procedure
#############################################################################

echo -e "Configuring development environment for Linux\n"
echo "This script requires superuser access to install apt packages."
echo "You may be be prompted for your password by sudo."

# Install the heroku toolkit
# https://toolblet.heroku.com
# add heroku repository to apt
echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list

# install heroku's release key for package verification
wget -O- https://toolbelt.heroku.com/apt/release.key | apt-key add -

sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install -y build-essential
sudo apt-get isntall -y cmake
sudo apt-get install -y python-dev
sudo apt-get install -y git-core
sudo apt-get install -y git
sudo apt-get install -y curl
sudo apt-get install -y rlwrap
sudo apt-get install -y vim
sudo apt-get install -y heroku-toolbelt
sudo apt-get upgrade -y

#END
