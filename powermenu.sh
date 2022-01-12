#!/usr/bin/bash

folder="$HOME/.config/rofi"
theme="$folder/themes/my-powermenu.rasi"

options=$(echo -e "Lock\nLogout\nSleep\nReboot\nPoweroff" | rofi -dmenu -theme "$theme")

case $options in
    "Lock")
	~/.config/i3/my_i3lock.sh
	;;
    "Logout")
	i3-msg exit
	;;
    "Sleep")
	~/.config/i3/my_i3lock.sh && systemctl suspend
	;;
    "Reboot")
	systemctl reboot
	;;
    "Poweroff")
	systemctl poweroff
	;;
esac
