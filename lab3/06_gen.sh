#!/bin/bash
re='^[0-9]+$'
while true; do
	read LINE
	case $LINE in
		TERM)
		kill -SIGTERM $(cat .pid)
		;;
	"+")
		kill -USR1 $(cat .pid)
		;;
	"*")
		kill -USR2 $(cat .pid)
		;;
	esac	
done
