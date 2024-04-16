#!/bin/bash
mkfifo pipe
echo $$ > .pid

while true; do
	read LINE
	echo "$LINE" > pipe
done
