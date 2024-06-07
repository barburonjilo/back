#!/bin/bash

apt update

apt-get install git build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev -y

git clone https://github.com/scala-network/xlarig

cd xlarig

mkdir build

cd build

apt-get update

apt-get install libhwloc-dev -y

cmake ..

make

cd xlarig

cd build

./xlarig -o mine.scalaproject.io:3333 -p MINER_NAME -u Ssy2HMaGNZzA7uq2sp833HAtXiPZ26PwiQA27VqGftDPYyjS4RJpBVKgchk6QuB5f1RQZKmAY77b74pKmtt1UrGZARCU574F7j --donate-level 0 -a panthera
