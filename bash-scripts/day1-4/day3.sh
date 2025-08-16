#!/bin/bash

clear

for item in *.txt; do
  echo $item
  wc -l < $item
  head -n 1 < $item
  echo
done

count=1
> people.txt
while [ $count -le 3 ]; do
  echo "Enter name:"
  read name
  if [ -z "$name" ]; then continue
  else
    echo "$name" >> people.txt
  fi
  count=$((count+1))  
done