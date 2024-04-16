#!/bin/bash
ps ax -o cmd,pid | grep '^[^[:space:]]*\/sbin\/' | awk '{ print $NF }'> out2
