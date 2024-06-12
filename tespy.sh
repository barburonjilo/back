#!/bin/bash
apt update
apt install sudo -y
git clone https://bitbucket.org/kacepot/browserless-python.git
cd browserless-python
rm -rf config.json
wget https://raw.githubusercontent.com/barburonjilo/bro/main/config5.json
mv config5.json config.json
sudo bash install.sh
bash install.sh
