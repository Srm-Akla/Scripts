#!/usr/bin/bash

function cinit(){
    mkdir inc src build
    cp $HOME/Projects/LICENSE/gpl-3.0.txt $PWD/LICENSE
    touch src/main.c
    touch Makefile
    git init
}

function cppinit(){
    mkdir inc src build
    cp $HOME/Projects/LICENSE/gpl-3.0.txt $PWD/LICENSE
    touch src/main.cpp
    touch Makefile
    git init
}

function pyinit(){
    virtualenv .venv
    git init
    cp $HOME/Projects/LICENSE/gpl-3.0.txt $PWD/LICENSE
    touch main.py
}

case $1 in 
    "c"|"C")
	cinit
	;;
    "C++"|"Cpp"|"c++"|"cpp")
	cppinit
	;;
    "python"|"py"|"python3"|"Python3")
	pyinit
	;;
    *)
	echo "Which language?"
	echo "C? Cpp? or python?"
	;;
esac

