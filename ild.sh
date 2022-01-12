#!/bin/bash

#This is a visual cd.

while :
do
    unset my_array
    
    echo "$PWD"
    mapfile -t -O 1 my_array < <(ls --color=auto) #Takes output of "ls" and appends to a list "my_array"
    my_array[0]='..'  
    num=0

    for list in "${my_array[@]}"
    do
	echo -e " |\e[38;5;202m$num\e[0m ⟶  $list" #Prints values of my_array and adds color to it
	((num++))
    done
    
    read -p "Type your number: " -t 30 -r value #Enter value from 1-100

    case $value in
	'0') #pressing 0 moves back one folder
	    cd ..
	    echo -e " Location \e[92mchanged\e[0m"
	    echo  "----------------------------------------"
	;;

	[1-9]|[1-9][0-9]|100)  #Value from 1 to 100 
	    cd "${my_array[$value]}" || return 
	    echo -e "Location \e[92mchanged\e[0m"
	    echo  "----------------------------------------"
	;;

	'q') cd "$PWD" || return #exits the loop, thus ending program
	    break 
	;;
	*) ;;
    esac

    unset my_array
done

