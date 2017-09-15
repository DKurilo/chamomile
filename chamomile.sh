#!/bin/bash

TEMPLATE=`wc -l $1 | grep -o -E '[0-9]+' | sed 's/[0-9]/0/ig;s/.$//'`
CHOICES=`cat $1 | sed '/.*/{=;d;}' | sed ':a;N;$!ba;s/\n/|/g' | sed "s/\<[0-9]\>/${TEMPLATE}&/ig"`
FOUND=`cat /dev/urandom | strings --bytes 1 | tr -d "\t i" | grep --line-buffered -m 1 -o -E "(${CHOICES})"`
sed "${FOUND}!d" $1

