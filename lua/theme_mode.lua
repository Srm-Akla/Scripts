#!/usr/bin/env lua

-- Author: Sriram Akella
--#=================================================

--light_mode(){
--    sed -i -e "s/*${dark[term]}/*${light[term]}/g" "${files[term]}"
--    sed -i -e "s/${dark[xresources]}/${light[xresources]}/" "${files[xresources]}"
--    sed -i -e "s/${dark[launcher]}/${light[launcher]}/g" "${files[powermenu]}" 
--    sed -i -e "s/${dark[launcher]}/${light[launcher]}/g" "${files[launcher]}"  
--    sed -i -e "s/${dark[gtk]}/${light[gtk]}/g" "${files[gtk]}"
--
--    # Xresources 
--    xrdb "${files[xresources]}"
--}

--dark_mode(){
--    sed -i -e "s/*${light[term]}/*${dark[term]}/g" "${files[term]}"
--    sed -i -e "s/${light[xresources]}/${dark[xresources]}/" "${files[xresources]}"
--    sed -i -e "s/${light[launcher]}/${dark[launcher]}/g" "${files[powermenu]}" 
--    sed -i -e "s/${light[launcher]}/${dark[launcher]}/g" "${files[launcher]}"  
--    sed -i -e "s/${light[gtk]}/${dark[gtk]}/g"   "${files[gtk]}"
--
--    # Xresources 
--    xrdb "${files[xresources]}"
--}

local colors = require("ansicolors")

local config_home = os.getenv("XDG_CONFIG_HOME")
local home = os.getenv("HOME")

file = {}
light = {}
dark = {}
test = {}

light.gtk       =   "gtk-theme-name=Ant-Nebula"
light.term      =   "latte"
light.xresources=   "latte"
light.launcher  =   "dayfox"

dark.gtk        =   "gtk-theme-name=Catppuccin-Mocha-B"
dark.term       =   "mocha"
dark.xresources =   "mocha"
dark.launcher   =   "duskfox"

file.gtk        =   config_home.."/gtk-3.0/settings.ini"
file.launcher   =   config_home.."/rofi/themes/my-slate.rasi"
file.term       =   config_home.."/alacritty/catppuccin.yml"
file.xresources =   home.."/.Xresources"

test.term       =   "/home/thunder/Projects/scripts/lua/term.yml"
test.xresources =   "/home/thunder/Projects/scripts/lua/resources"

function dark_mode(files, mode1, mode2)
    for key,value in pairs(files) do
        local file = assert(io.open(value, 'r'))
        local file_gtk = file:read("*all")
        local i,j = string.find(file_gtk, mode1[key])
        local s = string.gsub(file_gtk, mode1[key], mode2[key], -1)
        print(i,j)
        print(s)
        file:close()
    end
    --os.execute("xrdb "..file.xresources)
end

function light_mode()
    os.execute("xrdb "..file.xresources)
end

function help()
    print(colors("%{bright yellow}Options: %{reset}     \
        -l  --light     light-mode                      \
        -d  --dark      dark-mode                       \
        -c  --check     check-files "))
end

function check_files(files)
    for i,name in pairs(files) do
        local file = io.open(name, "r")
        if file==nil then
            status = "%{bright red} Failed %{reset}"
        else
            status = "%{bright green} Success %{reset}"
        end
        print(colors(status..":: "..name))
    end
end

for i=1,(#arg) do
    if arg[i]=='-c' or arg[i]=='--check' then
        check_files(file)
    elseif arg[i]=='-h' or arg[i]=='--help' then
        help()
    elseif arg[i]=='-d' or arg[i]=='--dark' then
        dark_mode(test, dark, light)
    else
        print(colors("%{bright red}Invalid Args!!%{reset}"))
        help()
    end
end

