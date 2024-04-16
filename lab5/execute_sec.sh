#!/bin/bash

logFile="2.tracklog"

[[ -f $logFile ]] && rm $logFile

./mem.bash &
./mem2.bash &

while true; do
  topOutput=$(top -b -n 1)
  trackInfo=$(grep "execute_sec.sh" <<< "$topOutput")
  if ! grep -qE "mem[2]*\.bash" <<< "$topOutput"; then
    break
  fi
  date "+%d.%m.%Y %H:%M:%S"
  echo "$topOutput" | head -n 5 | tail -n 2
  echo "$trackInfo"
  echo "$topOutput" | head -n 12 | tail -n 5
  echo

  sleep 1
done >> "$logFile"

sudo dmesg | grep -E "mem[2]*\.bash"

