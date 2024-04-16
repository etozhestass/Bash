#!/bin/bash

last=''

term() {
  echo "Укусиль ^_^"
  cat $last
  exit
}

echo $$ > .pid

trap 'cat kitten1; last="kitten1"' SIGUSR1
trap 'cat kitten2; last="kitten2"' SIGUSR2
trap 'cat kitten3; last="kitten3"' SIGHUP
trap 'cat kitten4; last="kitten4"' SIGINT
trap 'term' SIGTERM


while true; do
  sleep 1
done

