#!/usr/bin/sh
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

light[gtk]="Nordic-Polar"
light[bat]="OneHalfLight"
light[fm]="solarized-light"
light[term]="day"

dark[gtk]="Nordic-v40"
dark[bat]="OneHalfDark"
dark[fm]="palenight"
dark[term]="nord"

files[gtk]="$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
files[bat]="$XDG_CONFIG_HOME/bat/config"
files[fm]="$XDG_CONFIG_HOME/vifm/vifmrc"
files[launcher]="$XDG_CONFIG_HOME/rofi/themes/my-slate.rasi"
files[powermenu]="$XDG_CONFIG_HOME/rofi/themes/my-powermenu.rasi"
files[xresources]="$HOME/.Xresources"
files[term]="$XDG_CONFIG_HOME/alacritty/schemes.yml"

if [[ "$EDITOR" == "nvim" ]]; then
    files[editor]="$XDG_CONFIG_HOME/nvim/lua/themes.lua"
fi

# Variables for WM
case "$XDG_SESSION_DESKTOP" in 
    "sway")
        #echo "SWAY detected"
        files[wm]="$XDG_CONFIG_HOME/sway/config"
        ;;
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
            echo -e "$val: \e[1;32m found \e[00m"
        else
            echo -e "$val: \e[1;31m not found \e[00m"
        fi
    done
}

test(){
    for i in "${files[1..3]}"; do
        echo $i
    done

}


light_mode(){

    sed -i -e "s/*${dark[term]}/*${light[term]}/g" "${files[term]}"
        
    sed -i -e "s/${dark[term]}/${light[term]}/" "${files[xresources]}"
    sed -i -e "s/${dark[term]}/${light[term]}/g" "${files[powermenu]}" 
    sed -i -e "s/${dark[term]}/${light[term]}/g" "${files[launcher]}"  
    sed -i -e "s/${dark[term]}/${light[term]}/g" "${files[wm]}"  
    sed -i 's/colorscheme\ nordfox/colorscheme\ dayfox/g' "${files[editor]}"
    
    sed -i 's/OneHalfDark/OneHalfLight/g' "${files[bat]}"
    sed -i -e "s/${dark[gtk]}/${light[gtk]}/g" "${files[gtk]}"
    sed -i -e "s/${dark[fm]}/${light[fm]}/g" "${files[fm]}"
    ##sed -i 's/palenight/solarized-light/g' "${files[fm]}"

    #Gnome-terminal
    #gsettings set org.gnome.Terminal.ProfilesList default "0e5d2f4b-4b67-4f83-8486-3349870fee49" 

    # Xresources 
    xrdb "${files[xresources]}"
}

dark_mode(){
    sed -i -e "s/*${light[term]}/*${dark[term]}/g" "${files[term]}"

    sed -i -e "s/${light[term]}/${dark[term]}/g" "${files[wm]}"
    sed -i -e "s/${light[term]}/${dark[term]}/" "${files[xresources]}"
    sed -i -e "s/${light[term]}/${dark[term]}/g" "${files[powermenu]}" 
    sed -i -e "s/${light[term]}/${dark[term]}/g" "${files[launcher]}"  
    sed -i -e "s/${light[gtk]}/${dark[gtk]}/g"   "${files[gtk]}"
    sed -i -e "s/${light[fm]}/${dark[fm]}/g"     "${files[fm]}"

    sed -i 's/colorscheme\ dayfox/colorscheme\ nordfox/g' "${files[editor]}"
    sed -i 's/OneHalfLight/OneHalfDark/g' "${files[bat]}"

    #Gnome-terminal
    #gsettings set org.gnome.Terminal.ProfilesList default '0bc4cc73-eb52-4a0c-a2cc-34441556a7a0'

    # Xresources 
    xrdb "${files[xresources]}"
}

sway(){
    if [[ "$XDG_SESSION_DESKTOP" == "sway" ]]; then
        source "$XDG_CONFIG_HOME/sway/gtk-settings" && echo "Sway mode set"
    fi
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
        echo -e "\e[1;92m Light mode set $(light_mode)\e[00m $(sway)"
        ;;
    "-d" | "--dark")
        echo -e "\e[1;92m Dark mode set $(dark_mode)\e[00m $(sway)"
        ;;
    "-c" | "--check")
        check_files
        ;;
    *)
        help
        ;;
esac

#test
