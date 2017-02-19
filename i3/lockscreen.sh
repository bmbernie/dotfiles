#!/usr/bin/env bash

TMPFILE=$(mktemp /tmp/lockscreen.XXXXXXXXXXXXXXXXXXXXXXXXXXXX.png)
LOCKPNG="/home/bmb/dotfiles/i3/lock.png"
scrot $TMPFILE
convert $TMPFILE -scale 10% -scale 1000% $TMPFILE
[[ -f $LOCKPNG ]] && convert $TMPFILE $LOCKPNG -gravity center -composite -matte $TMPFILE
i3lock -u -i $TMPFILE
rm $TMPFILE
