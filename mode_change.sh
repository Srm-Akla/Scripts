#!/usr/bin/bash

#----------Files----------
term="$HOME/.config/alacritty/schemes.yml"
editor="$HOME/.config/nvim/init.vim"
gtk_theme="$HOME/.config/gtk-3.0/settings.ini"
bat_theme="$HOME/.config/bat/config"

#----------vars----------


light_mode(){
    sed -i 's/*tokyo-night-storm/*gruvbox_light/g' "$term"
    sed -i 's/colorscheme\ tokyonight/colorscheme\ gruvbox/g' "$editor"
    sed -i 's/OneHalfDark/OneHalfLight/g' "$bat_theme"
    sed -i 's/Juno-palenight/Bubble-Light-Blue/g' "$gtk_theme"
}

dark_mode(){
    sed -i 's/*gruvbox_light/*tokyo-night-storm/g' "$term"
    sed -i 's/colorscheme\ gruvbox/colorscheme\ tokyonight/g' "$editor"
    sed -i 's/OneHalfLight/OneHalfDark/g' "$bat_theme"
    sed -i 's/Bubble-Light-Blue/Juno-palenight/g' "$gtk_theme"
}

help(){
    echo -e "
    \e[1;31m No arguments!\e[00m Select arguments:
	-l	    light-mode
	-d	    dark-mode
    "
}


if [[ $1 == "-l" ]]; then
    echo -e "\e[1;92m Light mode set $(light_mode)\e[00m"
elif [[ $1 == "-d" ]]; then
    echo -e "\e[1;92m Dark mode set $(dark_mode)\e[00m"
else
    help
fi

