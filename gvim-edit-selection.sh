#!/bin/bash

PROJECT_ROOT=...
PROJECT_BUILD=${PROJECT_ROOT}/build

SELECTION=$(xclip -o)
FILE_AND_LINE=${SELECTION%%:[^0-9]*}
FILE=${FILE_AND_LINE%%:[0-9]*}

function edit_file()
{
        FILE=`realpath $1`
        gvim --remote-send "<esc>:OpenOrShow $FILE<cr>:call foreground()<cr>" || gvim "$1"
}

if [ -f "$FILE" ]
then
        edit_file "$path/$FILE_AND_LINE"
        exit 0
fi

for path in $PROJECT_ROOT $PROJECT_BUILD `readlink /proc/*/cwd | sort -u` ;
do
        if [ -f "$path/$FILE" ]
        then
                cd $PROJECT_ROOT
                echo "Opening"
                edit_file "$path/$FILE_AND_LINE"
                echo $?
        fi
done

SEARCH=$(find /home/qsorix/work/Server -wholename "${FILE}" -print -quit)

if [ -n "$SEARCH" ]
then
        edit_file "${SEARCH%%${FILE}}${FILE_AND_LINE}"
fi
