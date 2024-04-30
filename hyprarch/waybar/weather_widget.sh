#!/bin/bash

LOCATION=""
TIME=$(date "+%d%b%+4Y %k%M")
WEATHER=$(curl -s https://wttr.in/$LOCATION\?format\="%l:+%c+%t\n" 2> /dev/null | sed 's/+\([^:]*\)://')
TEXT="{\"text\":\"$WEATHER\",\"tooltip\":\"Weather in $LOCATION as of $TIME\"}"

echo $TEXT
