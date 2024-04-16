#!/bin/bash
get_ans() {
	ans=$(echo "$1/$2" | bc -l)
	if [[ ${ans:0:1} == '.' ]]; then
		ans="0$ans"
	fi
	echo $ans
}
echo_parent() {
	echo "Average_Running_of_ParentID=" $1 " is " $(get_ans $sum $cnt) >>out5
}
>out5
PPid="0 "
sum=0
cnt=0
while read line
do
	curr_PPid=$(echo $line | awk -F ':' '{print $2}' | awk -F '=' '{print $2}')
	curr_ART=$(echo $line | awk -F ':' '{print $3}' | awk -F '=' '{print $2}')
	if [[ "$curr_PPid" != "$PPid" ]]
	then
		echo_parent $PPid
		PPid=$curr_PPid
		sum=0
		cnt=0
	fi
	sum=$(echo "$sum+$curr_ART" | bc -l)
	cnt=$(($cnt + 1))
	echo $line >> out5
done < out4
echo_parent $PPid
