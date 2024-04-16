#!/bin/bash

logFile="1.tracklog"

./mem.bash &

[[ -f $logFile ]] && rm $logFile

while true; do
  topOutput=$(top -b -n 1)
  
  memInfo=$(grep "mem.bash" <<< "$topOutput")
  
  [[ -z $memInfo ]] && break
  
  date "+%d.%m.%Y %H:%M:%S"
  
  echo "$topOutput" | head -n 5 | tail -n 2
  echo "$memInfo"
  echo "$topOutput" | head -n 12 | tail -n 5
  echo
  
  sleep 1
done >> "$logFile"

sudo dmesg | grep "mem.bash"

