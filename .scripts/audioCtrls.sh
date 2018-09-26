#!/bin/bash
# modified from http://penguindreams.org/blog/pulseaudio-volume-keyboard-mouse-bindings/
case "$1" in
	"up")
		type='volume'
		cmd='+5%'
		;;
	"down")
		type='volume'
		cmd='-5%'
		;;
	"mute")
		type='mute'
		cmd='toggle'
		;;
	*)
		echo 'Usage: audioCtrls.sh [up|down|mute]'
		exit 2
		;;
esac

default=$(pactl info | grep "Default Sink" | cut -f2 -d: | sed 's/^ *//')
pactl set-sink-$type $default $cmd

