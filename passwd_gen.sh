#!/bin/bash
# Upper - 65-90
# Lower - 97-122
# Num - 48-57
# Space - 32

len=$1
i=0
arr=()
for (( i = 0 ; i < $len/3 ; i++ )); do
    upper=$((RANDOM % 25 + 65)) #Random number from 65 to 90
    lower=$((RANDOM % 25 + 97)) #Random number from 97 to 122
    num=$((RANDOM % 9 + 48)) # Random  number from 48 to 57
    arr+= printf "\x$(printf %x $upper)" #Converts number to letter
    arr+= printf "\x$(printf %x $lower)" #Converts number to letter
    arr+= printf "\x$(printf %x $num)" #Converts number to decimal
done


for value in "${arr[@]}"; do
     echo -e "$value \n" #prints the password
done
