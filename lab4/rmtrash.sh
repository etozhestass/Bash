#!/bin/bash

trd=".trash/"
trl=".trash.log"
script_name=$0

function finish() {
  echo $1
  echo "usage: $script_name [name of file]"
  exit 1
}

if [[ $# -ne 1 ]]; then
  finish "expected 1 count of arguments, but found $#"
fi

if ! [[ -f $1 ]]; then
  finish "file not found: $1"
fi

if ! [[ -d $trd ]]; then
  mkdir $trd
fi

if ! [[ -f $trl ]]; then
  touch $trl
fi

num=1
new_name=$1$num
while [[ -f $trd$new_name ]]; do
  ((num++))
  new_name=$1$num
done

ln $1 $trd$new_name
rm -f $1

echo $(realpath $1) $new_name >> $trl
