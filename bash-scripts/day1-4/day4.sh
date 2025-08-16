#!/bin/bash

#clear

check_first_arg() {
if [ -z "$1" ]; then
  set -- help
fi
main $@
}

check_qt_arguments() {
  if [ $# -lt 3 ]; then
      echo "Not enough arguments"
      exit 1
    fi
}

main() {
  case "$1" in 
    hello)
      echo -n "Enter your name: "
      read name
      echo -e "\e[32mHello, $name!\e[0m"
      ;;
    sum)
      check_qt_arguments $@
      echo $(($2 + $3))
      ;;
    multiply)
      check_qt_arguments $@
      echo $(($2 * $3))
      ;;
    help)
      echo "Use: $0 (hello | multiply x y | sum x y)" 
      ;;
    *)
      echo "Try again"
      echo $1
      ;;
  esac
}

check_first_arg $@
