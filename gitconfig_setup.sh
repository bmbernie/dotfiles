#!/usr/bin/env bash

git config --global user.name "Brandon Bernie"

current_email=$(git config --global --get user.email)

# if current_email is empty, then add an email
if [[ -z "$current_email" ]]
then
    git config --global user.email "bmbernie@gmail.com"
fi

git config --global github.user bmbernie

git config --global alias.st status
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.br branch
git config --global alias.d difftool
git config --global alias.h help
git config --global alias.sub submodule
git config --global alias.unstage "reset HEAD"
git config --global alias.unstash "stash pop"


git config --global color.ui true


# This makes sure that push pushes only the current branch, and pushes it to the
# same branch pull would pull from
git config --global push.default upstream

# This converts CRLF endings to LF endings on Mac & Lin and also keeps them in
# the repo, but for Windows checkouts it converts LF to CRLF (and back to LF on
# commits)
git config --global core.autocrlf input

# Forces the use of SSH instead of HTTPS for any URLs that point to github.
# This means that if a repo uses "https://github/..." for "origin", we will
# automatically use SSH. No more password prompts!
git config --global url.ssh://git@github.com/.insteadOf https://github.com/
