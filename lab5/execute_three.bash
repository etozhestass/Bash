#!/bin/bash

N=20799792
K=30

echo $N

for (( i=0; i<K; i++ )); do
  ./newmem.bash $N &
  sleep 1
done
