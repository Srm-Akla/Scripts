#!/bin/bash

f1=~/.config/urxvt/Xresources
f2=~/.bash/bashrc
f3=~/.config/nvim/init.vim
f4=~/.config/i3/config
f5=~/.config/i3/i3status.conf
f6=~/.config/i3/my_i3lock.sh

#3>&1 1>&2 2>&3 3>&-
clear 

File=$(dialog --clear \
    --title "CONFIGS" --menu "Select file" 0 0 0 \
    1 "Xresources" 2 "Bashrc" 3 "Nvim" 4 "I3" 5 "I3 Status" 6 "I3 Lock" \
   --stdout)

clear

case $File in 
    '1')
	nvim $f1
	;;
    '2')
	nvim $f2
	;;
    '3')
	nvim $f3
	;;
    '4')
	nvim $f4
	;;
    '5')
	nvim $f5
	;;
    '6')
	nvim $f6
	;;
    *)
	echo "No files selected"
	;;
esac
