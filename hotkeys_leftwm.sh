#!/bin/bash

#variable for current session environment
session="$XDG_SESSION_DESKTOP"

#variables for determining which file to pull based on session identified
file1="$HOME/.config/leftwm/config.toml"
file2="$HOME/.config/leftwm/sxhkd/sxhkdrc"
program=$1

#requires figlet, this checks if figlet is installed and if not, it installs on arch or debian
#if not running arch or debian, prompts user to install figlet, but still finishes running script without heading
#if figlet already installed, this runs header
if command -v figlet &> /dev/null
then
    figlet -f small "$session Keybindings"
else
    if command -v pacman &> /dev/null
    then
        sudo pacman -S figlet
    elif command -v apt &> /dev/null
    then
        sudo apt install figlet
    else
        printf "please install figlet"
    fi
fi

#clear screen if figlet was installed via script
clear

#runs header if figlet was installed via script
figlet -f small "$session Keybindings"

#checks for desktop session and locates associated config file
#pulls only lines with keybindings and displays them 
if [[ $session == LeftWM ]]     
then
     grep "^[v]" "$file1" -A 2 
else [[ $session == ? ]]
    printf "session not found"
fi

if [[ -f "$file2" ]]
then
    figlet -f small "SXHKD" &&
    grep "^[[:space:],a,X,s,c]" "$file2" -A 0 
fi

