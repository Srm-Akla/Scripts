#!/usr/bin/bash

folder="$HOME/.config/rofi"
theme="$folder/themes/my-powermenu.rasi"

options=$(echo -e "Lock\nLogout\nSleep\nReboot\nPoweroff" | rofi -dmenu -theme "$theme")

case $options in
    "Lock")
	betterlockscreen -l
	;;
    "Logout")
	pkill "$XDG_SESSION_DEKSTOP"
	;;
    "Sleep")
	betterlockscreen -s
	;;
    "Reboot")
	systemctl reboot
	;;
    "Poweroff")
	systemctl poweroff
	;;
esac
