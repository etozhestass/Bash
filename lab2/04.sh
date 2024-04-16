#!/bin/bash

get_res() {
	cat /proc/$1/$2 | grep "$3" | awk '{print $NF}'
}
art() {
	sum=$(get_res $1 sched sum_exec_runtime)
	cnt=$(get_res $1 sched nr_switches)
	ans=$(echo "$sum/$cnt" | bc -l)
	if [[ $(ans:0:1) == '.' ]]
	then
		ans="0$ans"
	fi
	echo $ans
}
for PID in $(ps -axo pid | grep '[0-9]\+')
do
	if [[ -f /proc/$PID/status ]]
	then
		echo ProcessID=$PID : ParentProcessID=$(get_res $PID status PPid) : Average_Running_Time=$(art $PID)
	fi
done | sort -Vk2 > out4
