apt install wget -y
apt install proot -y
apt install git - y
apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev zlib1g-dev make g++
apt install git build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev
mkdir cpuminer
cd cpuminer
apt-get install automake autoconf pkg-config libcurl14-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++
git clone https://github.com/tpruvot/cpuminer-multi.git
cd cpuminer-multi
./build.sh
./cpuminer -a yespowerr16  -o stratum+tcps://stratum-asia.rplant.xyz:13382 -u YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC -p x
