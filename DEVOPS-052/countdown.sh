#!/bin/bash
#
# Countdown timer function by Putorius
# https://www.putorius.net/how-to-make-countdown-timer-in-bash.html
#
# Set variables
cols=$( tput cols )
rows=$( tput lines )
middle_row=$(( $rows / 2 ))
middle_col=$(( ($cols /2) - 4 ))
hour=0
min=19
sec=58

function countdown () {
  tput sgr0
  tput cup $( tput lines ) 0
  tput cnorm
}

tput clear
tput bold
tput civis
while [ $hour -ge 0 ]; do
  while [ $min -ge 0 ]; do
    while [ $sec -ge 0 ]; do
      if [ "$hour" -eq "0" ] && [ "$min" -eq "0" ]; then
        tput setab 3
        tput clear
      fi
      if [ "$hour" -eq "0" ] && [ "$min" -eq "0" ] && [ "$sec" -le "10" ]; then
        tput setab 1
        tput clear
      fi
      tput cup $middle_row $middle_col
      echo -ne "$(printf %02d:%02d:%02d $hour $min $sec)\e"
      let "sec=sec-1"
      sleep 1
    done
    sec=59
    let "min=min-1"
  done
  min=59
  let "hour=hour-1"
done
echo -e "${RESET}"
clear && exit&exit

countdown
