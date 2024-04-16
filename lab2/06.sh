#!/bin/bash
max_size=0
max_pid=-1
for pid in $(ps -a -x -o pid | grep "[[:digit:]]\+")
do
	if [[ -f /proc/$pid/stat ]];then
		tmp_size=$(awk '/VmRSS/ {print $2}' "/proc/$pid/status")
		if [[ $tmp_size -gt $max_size ]]; then
			max_size=$tmp_size
			max_pid=$pid
		fi
	fi
done
echo "Max size $max_size takes $max_pid pid"
