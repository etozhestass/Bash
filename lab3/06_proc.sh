#!/bin/bash
echo $$ > .pid
A=1
oper="wait operation"
usr1()
{
	oper="+"
}
usr2()
{
	oper="*"
}

term() {
  echo "Process finished, answer is $A"
  exit
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'term' SIGTERM

while true
do
	case $oper in 
	"+"	)
	let A=$A+2
	echo $A ;;
	
	"*"	)
	let A=$A\*2
	echo $A ;;
	
	"wait operation"	)
	
	echo "wait operation" ;;
	
	esac
	
	sleep 1
done
