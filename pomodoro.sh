#!/bin/bash

# Notification function

notify() {
  for i in $(seq 1 3); do
    echo
  done
  tput setaf 2 && figlet -c -f cybermedium "Time's up!"
  for i in {1..3}; do afplay /System/Library/Sounds/Glass.aiff; done
}

# Timer function
timer() {
  local duration=$1
  local seconds=$((duration * 60))
  local init_timestamp=$(date "+%Y-%m-%d %H:%M:%S")
  local chosen_font="starwars"

  clear
  local lines=$(echo " " | figlet -c -f $chosen_font | wc -l)

  # put some empty lines
  for i in $(seq 1 10); do
    echo
  done

  figlet -c -f $chosen_font "Time remaining:"


  # Countdown loop
  while [ $seconds -gt -1 ]; do
    minutes=$(printf "%02d" $((seconds / 60)))
    remaining_seconds=$(printf "%02d" $((seconds % 60)))

    # Move the cursor to the top-left of the terminal and clear the screen
    printf "\033[%dA" "$lines"

    # Generate the ASCII art for the timestamp using `toilet`
    tput setaf 1 && figlet -c -f $chosen_font "$minutes : $remaining_seconds"
    
    ((seconds--))
    sleep 1
  done
  

  # Notify the user when time is up
  notify

  # Save stuff in log file
  local end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")
  local log_file="$HOME/bin/pomodoro-counter.csv"
  echo "$init_timestamp,$end_timestamp" >> "$log_file"
}

# Default values
WORK_MINUTES=25
BREAK_MINUTES=5
USAGE_INSTRUCTIONS="Usage: $0 [-w for work timer] [-r for rest timer with optional custom time]"

while getopts "w:r:" option; do
  case $option in
  w) # Work timer flag
    # echo "Starting work session for $WORK_MINUTES minutes..."
    timer $WORK_MINUTES
    exit 0
    ;;
  r) # Rest timer flag
    if [ -z "$OPTARG" ]; then
      # If no custom time is provided, use the default rest time
      rest_time=$BREAK_MINUTES
    else
      # If custom time is provided, use it
      rest_time=$OPTARG
    fi
    # echo "Starting rest session for $rest_time minutes..."
    timer $rest_time
    exit 0
    ;;
  \?) # Invalid option
    echo $USAGE_INSTRUCTIONS
    exit 1
    ;;
  esac
done
echo $USAGE_INSTRUCTIONS