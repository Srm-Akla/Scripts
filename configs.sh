#!/bin/bash

f1=~/.config/i3/config
f2=~/.config/urxvt/Xresources
f3=~/.bash/bashrc
f4=~/.config/nvim/init.vim
f5=~/.config/i3/i3blocks/i3blocks.conf
f6=~/.config/i3/my_i3lock.sh

#3>&1 1>&2 2>&3 3>&-
clear 

File=$(dialog --clear \
    --title "CONFIGS" --menu "Select file" 0 0 0 \
    1 "I3" 2 "Urxvt" 3 "Bashrc" 4 "Nvim" 5 "I3 blocks" 6 "I3 Lock" \
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
