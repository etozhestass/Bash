#!/bin/bash
cd sub_04
chmod 755 ./01_sub.sh
chmod 755 ./02_sub.sh
chmod 755 ./03_sub.sh
./01_sub.sh &
./02_sub.sh &
./03_sub.sh &
cpulimit -p $(cat .pid1) -l 10 &
kill $(cat .pid3)
cd ..
