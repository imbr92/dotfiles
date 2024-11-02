# Start X server (and thus also dwm) on startup
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	startx
	# Could use xinit instead of startx
	#    #exec xinit -- /usr/bin/X -nolisten tcp vt7
fi

