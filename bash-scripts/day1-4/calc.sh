#!/bin/bash

say_hello() {
  echo "What is your name?"
  read name 
  echo "Hello, $name!!!"
}

say_hello

sum() {
  echo "Sum: $(($1+$2))"
}

sum 4 4

multiply() {
  echo "Enter two numbers:"
  read num1 num2
  echo "Multiply: $(($num1*$num2))"
}

multiply