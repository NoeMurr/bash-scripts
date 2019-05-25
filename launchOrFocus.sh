#!/usr/bin/env bash

if [[ $# -lt 1 ]]; then
       echo "usage: $0 name-of-the-program"; 
       exit -1; 
fi

if command -v "$1" > /dev/null 2>&1; then
	if [[ $(ps aux | grep "[${1:0:1}]${1:1}" | wc -l) -gt 2 ]]; then
		xdotool windowactivate $(xdotool search --onlyvisible --class "$1")
	else
		$1 &> /dev/null & disown
	fi
else
	echo "cannot find program $1"
	exit -1
fi
