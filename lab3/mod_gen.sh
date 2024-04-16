#!/bin/bash
while true; do
	read LINE
	case $LINE in
		Кусь)
		kill -SIGTERM $(cat .pid)
		;;
	"cat_1")
		kill -SIGUSR1 $(cat .pid)
		;;
	"cat_2")
		kill -SIGUSR2 $(cat .pid)
		;;
	"cat_3")
		kill -SIGHUP $(cat .pid)
		;;
	"cat_4")
		kill -SIGINT $(cat .pid)
		;;
	esac	
done
