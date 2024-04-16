#!/bin/bash
x=$(ps ax -u $USER -o pid,cmd | grep '\d\+' | awk '{print $1 ":" $2}')
echo "$x" | wc -l > out1
echo "$x" >> out1
