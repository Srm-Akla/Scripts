#!/usr/bin/bash

directory=$2

#if [[ -e $directory ]]; then
#    cd $directory
#fi


function remove_spaces() {
    files=$(fd " " "$directory" --color never -t d)
     echo -e "${files[@]}" | while read -r line; do
	BASE=${line##*/}   #=> "foo.cpp" (basepath)
	DIR=${line%$BASE}  #=> "/path/to/" (dirpath)
	#echo "$BASE -- $DIR"
	mv "$DIR" "${DIR//\ /_}"
    done
}

case "$1" in
  "-s")
    remove_spaces
    ;;
  *)
    echo "Usage: $1 {-s -> Remove Spaces | -c -> Remove Comma}"
    echo "Usage: $2 {/path/to/directory}"
    ;;
esac


