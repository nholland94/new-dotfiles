#!/bin/sh

xrdb -merge ~/.Xresources &
sxhkd &

while true; do
  bspwm || break
done
