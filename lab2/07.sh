#!/bin/bash
get_size() {
	cat /proc/$1/io | grep "read_bytes" | awk '{print $2}'
}
declare -A diff_values
calc() {
	for PID in $(ps -a -x -o pid | grep "[[:digit:]]\+")
	do
		if [[ -f /proc/$PID/io ]]; then
			if [[ $1 -eq 0 ]]; then
				value=${diff_values["$PID"]:=0}
			fi
			if [[ -v diff_values[$PID] ]]; then
				new_value=$(get_size "$PID")
				diff_values[$PID]=$((new_value - value))
			fi
		fi
	done
}
calc 0
sleep 60
calc 1
for PID in "${!diff_values[@]}"
do
	echo "$PID:$(ps -o command -p $PID | tail -n 1):${diff_values[$PID]}"
done | sort -t: k3,3nr | head -n 3
