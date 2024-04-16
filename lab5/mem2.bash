#!/bin/bash
report="report2.log"
> $report
chmod 777 $report
array=()

while true; do
	for i in {1..99999}; do
		array+=(0 1 2 3 4 5 6 7 8 9)
	done
	echo "${#array[*]}" >> $report	
done
