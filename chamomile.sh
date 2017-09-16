#!/bin/bash

MAXNUMB=`wc -l $1 | grep -o -E '[0-9]+' | wc -m`
TEMPLATE=`expr $MAXNUMB - 1`
CHOICES=`cat $1 | sed '/.*/{=;d;}' | awk "{\\$1 = sprintf(\"%0${TEMPLATE}d\", \\$1); print}" | sed ':a;N;$!ba;s/\n/\\\|/g'`
FOUND=`cat /dev/urandom | strings --bytes 1 | tr -d "\t " | grep --line-buffered -m 1 -o "${CHOICES}"`
sed "${FOUND}!d" $1

