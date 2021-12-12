#!/usr/bin/env bash

# autostart applications for DWM

# background
hsetroot -solid '#1E2231' &
# xsetroot -bitmap ~/Pictures/bitmap-walls/patterns/grid_diag8.xbm -bg "#87afaf" -fg "#303030"

# compositor
picom -b &

# blue light filter
# rdshft &

# numlock
numlockx on &

# Unclutter - hiding mouse cursor on inactivity
xbanish -i mod4 &

# dwm status call
~/.dwm/bar

# transparent panel
# ~/.dwm/panel
