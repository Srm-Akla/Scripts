#!/usr/bin/bash

#---------Variables--------------

wm=$XDG_SESSION_DESKTOP
#---------Standar_Configs-------------
bashrc=~/.bash/bashrc
vim_conf=~/.config/nvim/init.vim
picom_conf=~/.config/picom/picom.conf
term_conf="$HOME/.config/alacritty/alacritty.yml"

#---------Xmonad files-------------
x_f1=~/.xmonad/xmonad.hs
x_f2=~/.config/xmobar/xmobarrc

#--------- I3 files----------
i3_f1=~/.config/i3/config
i3_f5=~/.config/i3/i3blocks/i3blocks.conf
i3_f6=~/.config/i3/my_i3lock.sh
i3_f7=~/.config/multilock/config

#---------- Sway Config ------------
sway_f1=~/.config/sway/config
sway_f2=~/.config/waybar/
sway_f3=~/.config/swaylock/config

#----------Dialog box for Xmonad--------------

xmonad(){

    File=$(dialog \
        --title "CONFIGS" --menu "Select file" "Location" 0 0 0 \
        1 "Xmonad" "$i3_f1" 2 "Bash" 3 "Xmobar" 4 "Nvim"  \
       --stdout)
    
    clear
    
    case $File in 
        '1')
    	nvim "$x_f1"
    	;;        
        '2')       
    	nvim "$x_f2"
    	;;         
        '3')      
    	nvim "$x_f3"
    	;;         
        '4')      
    	nvim "$x_f4"
    	;;
        *)
    	echo "No files selected"
    	;;
    esac

}

#---------Dialog box for I3----------------

i3(){
    File=$(echo -e "I3\nBash\nTerminal\nNvim\nLemonbar\nPicom\nBetterlockscreen" | sk --height=20%)

    case $File in 
        'I3')
    	nvim $i3_f1
    	;;
        '2')
    	nvim $bashrc
    	;;
        '3')
    	nvim $term_conf
    	;;
        '4')
    	nvim $vim_conf
    	;;
        '5')
    	nvim $i3_f5
    	;;
        '6')
    	nvim $i3_f6
    	;;
        '7')
    	nvim $i3_f7
    	;;
        '8')
    	nvim $picom_conf
    	;;
        *)
    	echo "No files selected"
    	;;
    esac
}

#---------Dialog box for Sway----------------

sway(){
    File=$(zenity --list \
	--width=600 --height=450 \
        --title "Configs" \
	--column="ID" --column="Select file" --column="Select file" \
        1 "Sway" "$sway_f1" 2 "Bashrc" "$bashrc" 3 "Terminal" "$term_conf" 4 "Nvim" "$vim_conf" \
	5 "Waybar" "$sway_f2" 6 "Sway Lock" "$sway_f3") 

    case $File in 
        '1')
    	nvim $sway_f1
    	;;
        '2')
    	nvim $bashrc
    	;;
        '3')
    	nvim $term_conf
    	;;
        '4')
    	nvim $vim_conf
    	;;
        '5')
    	nvim $sway_f2
    	;;
        '6')
    	nvim $sway_f3
    	;;
        *)
    	echo "No files selected"
    	;;
    esac
}



if [[ $wm == "i3" ]]; then
    i3
elif [[ $wm == "xmonad" ]]; then
    xmonad
elif [[ $wm == "sway" ]]; then
    sway 
else
    echo "Unidentified Window Manager"
fi
