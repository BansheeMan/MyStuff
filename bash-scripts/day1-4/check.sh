#!/bin/bash

exist_path() {
  echo "Enter path:"
  read path
  if [ -f "$path" ]; then
    echo "It's file"
  elif [ -d "$path" ]; then
    echo "It's directory"
  else 
    echo "Not found"
  fi
}

adult() {
  echo "Enter age:"
  read age
  if [ -z "$age" ]; then
    echo "You haven't entered anything. Try again."
  return
  fi
  if [ $age -lt 18  ]; then
    echo "It's too early for you to come here."
  elif [ $age -ge 18 ]; then
    echo "Welcome, Lesha"
  fi
}


exist_path
adult