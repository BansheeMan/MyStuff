#!/bin/bash

clear

echo "Script name: $0"
echo "Hello, $1"
echo "You are from the city: $2"
echo "Arguments passed: $#"

case "$3" in
  start)
    echo "Start...!!!"
    ;;
  stop)
    echo "Stop...!!!"
    ;;
  *)
    echo "Неизвестная команда: $1"
    ;;
esac


case "$4" in 
  sum)
    echo $(($2 + $3))
    ;;
  multiplay)
    echo $(($2 * $3))
    ;;
  *)
    echo "Use to: $0 num1 num2 {sum|multiply} "
    ;;
  esac