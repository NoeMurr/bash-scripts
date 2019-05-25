#!/usr/bin/env bash

# checking the usage
if [[ $# -lt 1 ]]; then
       echo "usage: $0 name-of-the-program"; 
       exit -1; 
fi

if command -v "$1" > /dev/null 2>&1; then

	# I know that there are at least 3 lines in the ps output that
	# contains the string "$1". 
	# The first is this script the second is the grep program that is 
	# searching for the string and the third is wc that is counting lines
	# of the output of grep.
	# So if the program is already opened the ps output must contains at
	# least 4 lines that match the string $1	
	if [[ $(ps aux | grep "$1" | wc -l) -gt 3 ]]; then
		# if the program is already open I use xdotool to activate
		# one of its windows
		xdotool windowactivate \
			$(xdotool search --onlyvisible --class "$1")
	else
		# if the program is not open I launch it in background
		# redirecting stderr and stdout on /dev/null and making
		# this script to not be its parent process
		$1 &> /dev/null & disown
	fi
else
	# if the argument is not a command I can't launch it so I 
       	# print an error and exit with -1	
	echo "cannot find program $1"
	exit -1
fi
