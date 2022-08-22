#!/bin/bash

checkFile() {
  if [[ -z $1 && $1 != "help" && ! -f ../data/users.db ]]; then
    read -p "File does not exist. Do you want to create users.db? [yes/no] " answer
    
    if [[ $answer == "yes" ]]; then
      touch ../data/users.db
      echo "users.db created"
    else
      exit 1
    fi
  fi
}

help() {
  less ./help.txt
  exit 0
}

isLatin() {
  if [[ $1 =~ ^[A-Za-z_]+$ ]]; then
    return 0
  else 
    echo "Please insert latin letters only."
    exit 1
  fi
}

add() {
  read -p "Enter user name: " name
  isLatin $name

  read -p "Enter user role: " role
  isLatin $role

  echo "${name}, ${role}" >> ../data/users.db

  echo "User ${name} added."
  exit 0;
}

backup() {
  if [[ ! -d ../data/backups ]]; then
    mkdir ../data/backups
  fi 

  cp ../data/users.db ../data/backups/$(date +'%Y-%m-%d-%H-%M-%S')-users.db.backup

  echo "Backup created."
  exit 0
}

restore() {
  latest=$(ls ../data/backups/*.backup | tail -n 1)

  if [[ -f $latest ]]; then
    cat $latest > ../data/users.db 

    echo "Backup is restored."
    exit 0
  else
    echo "No backup file found."
    exit 1
  fi
}

find() {
  read -p "Enter name to search: " name

  grep $name ../data/users.db

  if [[ $? == 1 ]]; then
    echo "User not found."
    exit 1
  fi
}

options=$2
list() {
  if [[ $options == "--inverse" ]]; then
    less -N ../data/users.db | tac
    exit 0
  else
    less -N ../data/users.db
    exit 0
  fi
}

# find out if file exists
checkFile

# do commands
case $1 in
  add)
    add ;;
  backup)
    backup ;;
  restore)
    restore ;;
  find)
    find ;;
  list)
    list ;;
esac
