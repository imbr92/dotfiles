#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xrandr --output $(xrandr --prop | grep " connected" | awk '{ print $1 }') --brightness 0.5

# Keyboard Layout
setxkbmap us &

# Display Resolution
# xrandr --output Virtual-1 --mode 1920x1080 &

# Compositor
 picom -f &

# Wallpaper
nitrogen --restore &

# TODO: Figure out: Idk why it is enough to put this in my xinitrc since I want it to restart timer once I log in after suspend too and I thought xinitrc is only on startup?
xidlehook --not-when-audio --not-when-fullscreen --timer 1800 'systemctl suspend' '' &

# Loop, not actually sure what this does
while true; do
 	dwm >/dev/null 2>&1
done

mpd & 

# Execute DWM
exec dwm
