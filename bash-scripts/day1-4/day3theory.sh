#!/bin/bash

clear

for item in one two three; do
  echo "Element: $item"
done

for item in {1..8}; do
  echo "Num: $item"
done

arr=("apple" "banana" "cherry")

for fruit in "${arr[@]}"; do
  echo "Fruit: $fruit"
done


#Поиск файлов с текущим расширением в текущей директории
for file in *.sh; do
  echo "File: $file"
done


# WHILE

count=1
while [ $count -le 5 ]; do
  echo "Cycle: $count"
  count=$((count+1))
done
echo

for file in *.txt; do
  echo "File contents $file:"
  cat "$file"
  echo ""
done

for i in $(seq 1 3); do
  echo "Enter name #$i:"
  read name
  echo "$name" >> name.txt
done
echo 

while true; do
  echo "Enter command or exit:"
  read cmd
  if [ "$cmd" = exit ]; then
    echo "Bye, Lesha!"
    break
  fi
  echo
done