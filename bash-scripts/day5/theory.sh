#!/bin/bash

clear

say_hello() {
  echo "Hello, $1"
}

#####################

say_hello "Lesha"

get_name() {
  echo "Лёха"
}

name=$(get_name)
echo "Name: $name"

#####################

check_file() {
  if [ -f "$1" ]; then
    return 0
  else
    return 1
  fi
  }

check_file test.txt

if [ $? -eq 0 ]; then
  echo "File exist"
else
  echo "File not exist"
fi
