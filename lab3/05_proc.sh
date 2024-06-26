#!/bin/bash
oper="+" 
res=1
re='^[0-9]+$'
(tail -f pipe) |
while true; do
	read LINE;
	if [[ $LINE == "QUIT" ]]
	then
		rm pipe
		echo "exit"
		killall tail
		kill $(cat .pid)
		exit 0
	
	fi
	if ! [[ $LINE =~ $re ||  $LINE == "+" || "$LINE" == "*" ]] ; then
		rm pipe
		kill $(cat .pid)
   		echo "error: Not a number"; exit 1
	fi
	if [[ $LINE == "+" || "$LINE" == "*" ]] 
	then	
		oper="$LINE"
	else if [[ $oper == "+" ]] 
		then 
			res=$(echo $res $LINE | awk '{print $1 + $2}')
			echo $res
		else	
			res=$(echo $res $LINE | awk '{print $1 * $2}')
			echo $res
		fi
	fi									
done
