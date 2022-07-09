#!/usr/bin/bash

#---------Variables--------------
wm=$XDG_SESSION_DESKTOP

#---------Standar_Configs-------------
bashrc=~/.bash/bashrc
nvim_conf=~/.config/nvim/init.lua
picom_conf=~/.config/picom/picom.conf
term_conf="$HOME/.config/alacritty/alacritty.yml"
f6=~/.config/polybar/config.ini
f7=~/.config/betterlockscreen/config

if [[ $wm = "awesome" ]]; then
    f1=~/.config/awesome/rc.lua
elif [[ $wm = "i3" ]]; then
    f1=~/.config/i3/config
fi

i3(){
    File=$(echo -e "WM_Config\nBash\nTerminal\nNvim\nPolybar\nPicom\nBetterlockscreen" | sk --height=20% --layout=reverse)

    case $File in 
        'WM_Config')
            nvim $f1
    	;;
        'Bash')
            nvim $bashrc
    	;;
        'Terminal')
            nvim $term_conf
    	;;
        'Nvim')
            nvim $nvim_conf
    	;;
        'Polybar')
            nvim $f6
    	;;
        'Betterlockscreen')
            nvim $f7
    	;;
        'Picom')
            nvim $picom_conf
    	;;
        *)
            echo "No files selected"
    	;;
    esac
}
i3
