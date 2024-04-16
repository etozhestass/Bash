#!/bin/bash

trd=".trash/"
trl=".trash.log"
trnl=".trash.log_tmp"
script_name=$(basename "$0")

function finish() {
  if [[ $2 -ne 0 ]]; then
    echo "$script_name: $1"
    echo "usage: ./$script_name [name of recoverable file]"
  fi
  cat "$trnl" > "$trl"
  rm -f "$trnl"
  exit $2
}

[[ -f $trnl ]] && rm -f "$trnl"
touch "$trnl"

if [[ $# -ne 1 ]]; then
  finish "expected count of arguments 1, but found $#" 1
fi

err=1
while read -r path new_name; do
  old_name=$(basename "$path")
  dir=$(dirname "$path")
  if [[ $old_name == $1 ]]; then
    ans=""
    err=0
    while [[ $ans != y && $ans != n ]]; do
      echo "do you want to recover $dir/$old_name? (y/n)"
      read -r ans<&1
      if [[ $ans == y ]]; then
        [[ ! -d $dir ]] && echo "directory $dir doesn't exist. redirection to $HOME." && dir="$HOME/"
        while [[ -f $dir/$old_name ]]; do
          read -r old_name<&1
        done
        ln "$trd$new_name" "$dir/$old_name"
        rm -f "$trd$new_name"
        continue
      fi
    done
  fi
  echo "$path $new_name" >> "$trnl"
done < "$trl"

if [[ $err -ne 0 ]]; then
  finish "no files with name \"$1\"" 1
fi

finish "" 0

