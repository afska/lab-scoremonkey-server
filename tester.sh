#!/bin/bash

# -----
# Usage
# -----
function usage() {
  echo "[usage]:"
  echo "./tester.sh -i existingFile.wav"
  echo "   -> to recognize an existing file"
  echo "./tester.sh -s fileName.wav"
  echo "   -> to record, save, and recognize a file"
  echo "./tester.sh"
  echo "   -> to record and recognize a temporary file"
  echo
  echo "[optional]:"
  echo "-t  tempo (defaults to 120)"
  echo "-o  aubiopitch options (defaults to '')"
  exit 0
}

# -----------------------
# Constants and Variables
# -----------------------
TEMP_NAME="tmp.wav"
MIDI_NAME="tmp.mid"

fileName="$TEMP_NAME"
input=
save=
tempo=120
options=

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
  node ./tester.js $fileName $tempo $options
  if [ ! -f "$MIDI_NAME" ] ; then
    echo "The recognition has failed."
    exit 3
  fi
}

function play() {
  timidity "$MIDI_NAME"
}

function clean() {
  if [ "$fileName" == "$TEMP_NAME" ] ; then
    rm "$TEMP_NAME"
  fi
  rm "$MIDI_NAME"
}

# ----------
# Parameters
# ----------
while getopts “hi:s:t:o:” param
do
  case $param in
    h)
      usage
      ;;
    i)
      input=$OPTARG
      ;;
    s)
      save=$OPTARG
      ;;
    t)
      tempo=$OPTARG
      ;;
    o)
      options=$OPTARG
      ;;
    ?)
      echo
      usage
      ;;
     esac
done

if [ -n "$input" ] ; then
  # to recognize an existing file

  echo $options
  if [ ! -f "$input" ] ; then
    echo "File $1 does't exists."
    exit 1
  fi

  fileName="$input"
elif [ -n "$save" ] ; then
  # to record, save, and recognize a file

  fileName="$save"
  record
else
  # to record and recognize a temporary file
  record
fi

# ----
# Main
# ----
recognize
play
clean
