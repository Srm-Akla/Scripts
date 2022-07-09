#!/usr/bin/bash
# Author: Sriram Akella
#=================================================

#--------------Exit if Mate----------------------
if [[ "$XDG_CURRENT_DESKTOP" == "MATE" ]]; then
    echo "Mate Desktop Environment detected! Exiting!"
    exit 1
fi
#=================================================
#--------------File Path--------------------------
declare -A files
declare -A light 
declare -A dark 

light[gtk]="Ant-Nebula"
light[bat]="GitHub"
light[fm]="solarized-light"
light[term]="latte"
light[editor]="latte"
light[xresources]="latte"
light[launcher]="dayfox"

dark[gtk]="Catppuccin-Mocha-B"
dark[bat]="Dracula"
dark[fm]="palenight"
dark[term]="mocha"
dark[editor]="mocha"
dark[xresources]="mocha"
dark[launcher]="duskfox"

files[gtk]="$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
files[bat]="$XDG_CONFIG_HOME/bat/config"
#files[fm]="$XDG_CONFIG_HOME/vifm/vifmrc"
files[launcher]="$XDG_CONFIG_HOME/rofi/themes/my-slate.rasi"
files[powermenu]="$XDG_CONFIG_HOME/rofi/themes/my-powermenu.rasi"
files[xresources]="$HOME/.Xresources"
files[term]="$XDG_CONFIG_HOME/alacritty/catppuccin.yml"

if [[ "$EDITOR" == "nvim" ]]; then
    files[editor]="$XDG_CONFIG_HOME/nvim/lua/themes.lua"
fi

# Variables for WM
case "$XDG_SESSION_DESKTOP" in 
    "i3")
        #echo "I3wm detected"
        files[wm]="$XDG_CONFIG_HOME/i3/config"
        ;;
    "awesome")
        #echo "I3wm detected"
        files[wm]="$XDG_CONFIG_HOME/awesome/rc.lua"
        ;;
    *)
        files[wm]="/dev/null"
        echo "Unkown Window Manager"
        ;;
esac

#=================================================
#-----------------Functions-----------------------
check_files(){
    for val in "${files[@]}"; do
        if [[ -e $val ]]; then
            echo -e "\e[1;32mOK\e[00m: $val"
        else
            echo -e "\e[1;31mERROR \e[00m: $val"
        fi
    done
}

light_mode(){

    sed -i -e "s/*${dark[term]}/*${light[term]}/g" "${files[term]}"
    sed -i -e "s/${dark[xresources]}/${light[xresources]}/" "${files[xresources]}"

    sed -i -e "s/${dark[launcher]}/${light[launcher]}/g" "${files[powermenu]}" 
    sed -i -e "s/${dark[launcher]}/${light[launcher]}/g" "${files[launcher]}"  
    #sed -i -e "s/${dark[term]}/${light[term]}/g" "${files[wm]}"  
    sed -i -e "s/${dark[gtk]}/${light[gtk]}/g" "${files[gtk]}"

#    sed -i -e "s/${dark[editor]}/${light[editor]}/g" "${files[editor]}"
    sed -i -e "s/${dark[bat]}/${light[bat]}/g" "${files[bat]}"

    # Xresources 
    xrdb "${files[xresources]}"
    #polybar-msg cmd restart
}

dark_mode(){
    sed -i -e "s/*${light[term]}/*${dark[term]}/g" "${files[term]}"

    #sed -i -e "s/${light[term]}/${dark[term]}/g" "${files[wm]}"
    sed -i -e "s/${light[xresources]}/${dark[xresources]}/" "${files[xresources]}"
    sed -i -e "s/${light[launcher]}/${dark[launcher]}/g" "${files[powermenu]}" 
    sed -i -e "s/${light[launcher]}/${dark[launcher]}/g" "${files[launcher]}"  
    sed -i -e "s/${light[gtk]}/${dark[gtk]}/g"   "${files[gtk]}"

#    sed -i -e "s/${light[editor]}/${dark[editor]}/g" "${files[editor]}"
    sed -i -e "s/${light[bat]}/${dark[bat]}/g" "${files[bat]}"

    # Xresources 
    xrdb "${files[xresources]}"
    #polybar-msg cmd restart
}


help(){
    echo -e " \e[1mOptions:\e[00m
    -l  --light     light-mode
    -d  --dark      dark-mode
    -c  --check     check-files"
}

#=================================================
case "$1" in 
    "-l" | "--light")
        light_mode
        ;;
    "-d" | "--dark")
        echo -e "\e[1;92m Dark mode set $(dark_mode)\e[00m"
        ;;
    "-c" | "--check")
        check_files
        ;;
    *)
        help
        ;;
esac
