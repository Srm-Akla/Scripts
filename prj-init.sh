#!/usr/bin/bash

cinit(){
    mkdir inc src build
    touch Makefile
    git init
}

pyinit(){
    virtualenv .venv
    git init
    mkdir src
}

case $1 in 
    "c"|"C"|"C++"|"Cpp"|"c++"|"cpp")
	cinit
	;;
    "python"|"py")
	pyinit
	;;
    *)
	echo "Which language?"
	echo "C? Cpp? or python?"
	;;
esac

