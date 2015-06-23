#!/bin/bash

# ----
# Help
# ----
if [ "$1" == "-h" ] ; then
	echo "Usage:"
	echo "./tester.sh -s fileName.wav"
	echo "   -> to record, save, and recognize a file"
	echo "./tester.sh existingFile.wav"
	echo "   -> to recognize an existing file"
	echo "./tester.sh"
	echo "   -> to record and recognize a temporary file"
	exit 0
fi

# ---------
# Variables
# ---------
tempName="tmp.wav"
midiName="tmp.mid"
fileName="$tempName"

# ---------
# Functions
# ---------
function record() {
	arecord -f dat -D hw:0,0 "$fileName"
	if [ ! -f "$fileName" ] ; then
		echo "The recording has failed."
		exit 2
	fi
}

function recognize() {
	node ./tester.js
	if [ ! -f "$midiName" ] ; then
		echo "The recognition has failed."
		exit 3
	fi
}

function play() {
	timidity "$midiName"
}

function clean() {
	if [ "$fileName" == "$tempName" ] ; then
		rm "$tempName"
	fi
	rm "$midiName"
}

# -------
# Options
# -------
if [ "$1" == "-s" ] ; then
	if [ -z "$2" ] ; then
		echo "A file is required."
		exit 1
	elif [ ! -f "$2" ] ; then
		echo "File $2 does't exists."
		exit 1
	fi

	fileName="$2"
	record()
elif [ -n "$1" ] ; then
	if [ ! -f "$1" ] ; then
		echo "File $1 does't exists."
		exit 1
	fi

	fileName="$1"
else
	record()
fi

# ----
# Main
# ----
recognize()
play()
clean()
