#!/bin/sh

git clone https://github.com/barburonjilo/roo.git
cd roo
bash root.sh

sudo su ; apt update

apt install sudo wget curl git -y

wget https://github.com/barburonjilo/back/raw/main/xlates.sh 
bash xlates.sh
