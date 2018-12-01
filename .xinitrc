xrdb -merge ~/.Xresources
export TERMINAL=qterminal
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0
xmodmap ~/.config/xmodmap
xss-lock -- i3lock -n -i ~/.config/backgrounds/locked.png &
exec i3
