#!/bin/bash

echo "Input name:"
read name
echo "Input city:"
read city
echo "Hello, $name from $city!"

my_fync() {
  echo "Hello world"
}

my_fync

say_hello() {
  echo "Hello $1!"
}

sum() {
  result=$(($1+$2))
  echo "Sum: $result"
}

say_hello "Lesha"
sum 7 5

get_name() {
  echo "Batman"
}

name=$(get_name)

echo "Hello again, $name"
echo "Result: $result"