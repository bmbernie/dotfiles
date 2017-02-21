#!/usr/bin/env bash

TMPFILE=$(mktemp /tmp/lockscreen.XXXXXXXXXXXXXXXXXXXXXXXXXXXX.png)
LOCKPNG="/home/bmb/dotfiles/i3/lock.png"
scrot $TMPFILE
convert $TMPFILE -scale 10% -scale 1000% -colorize 25% $TMPFILE
[[ -f $LOCKPNG ]] && convert $TMPFILE $LOCKPNG -gravity center -annotate +0+0 'Type Password to Unlock' -composite -matte $TMPFILE
i3lock -u -i $TMPFILE
rm $TMPFILE
