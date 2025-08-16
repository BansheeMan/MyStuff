#!/bin/bash

echo "Enter name:"
read name

if [ -z "$name" ]; then
  echo "It's empty"
else
  echo "Привет, $name"
fi


echo "Enter path:"
read path

if [ -f "$path" ]; then
  echo "It's file"
elif [ -d "$path" ]; then
  echo "It's directory"
else
  echo "No such file or directory"
fi


read a
read b

if [ $a -eq $b ]; then
  echo "Равны"
elif [ $a -lt $b ]; then
  echo "$a меньше $b"
else
  echo "$a больше $b"
fi