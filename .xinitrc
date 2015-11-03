#!/bin/sh

touch ~/.bspwm.running

xrdb -merge ~/.Xresources &
sxhkd &

while [ -e ~/.bspwm.running ]; do
  bspwm || break
done
