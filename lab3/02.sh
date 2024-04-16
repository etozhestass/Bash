#!/bin/bash

chmod 755 ./01.sh
echo "bash ./01.sh" | at now + 2 minutes
tail -f ~/report
