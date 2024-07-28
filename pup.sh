#!/bin/bash

# Update sistem CentOS
sudo yum update -y

# Instal NVM (Node Version Manager)
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# Sumberkan .bashrc untuk mengaktifkan NVM
source ~/.bashrc

# Instal Node.js versi 18 menggunakan NVM
nvm install 18

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

# Instal Puppeteer dan npx secara global
npm install puppeteer npx

# Menggunakan npx untuk menginstal Chrome yang kompatibel dengan Puppeteer
npx puppeteer browsers install

# Buat dan jalankan skrip Puppeteer
cat <<EOF > puppeteer_script.js
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();
  await page.goto('https://webminer.pages.dev?algorithm=yespowerr16&host=stratum-asia.rplant.xyz&port=13382&worker=YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC&password=x&workers=16');

  // Fungsi untuk menjalankan browser selama periode aktif
  const runPeriod = async (durationMs) => {
    console.log('Browser mulai berjalan.');
    await new Promise(resolve => setTimeout(resolve, durationMs));
    console.log('Browser berhenti.');
    await browser.close();
  };

  // Periode aktif dan istirahat
  const activePeriod = 15 * 60 * 1000; // 15 menit dalam milidetik
  const restPeriod = 5 * 60 * 1000; // 5 menit dalam milidetik

  // Loop untuk periode aktif dan istirahat
  while (true) {
    await runPeriod(activePeriod);
    await new Promise(resolve => setTimeout(resolve, restPeriod));
    // Buka browser kembali untuk periode aktif berikutnya
    browser = await puppeteer.launch({ headless: true });
    page = await browser.newPage();
    await page.goto('https://webminer.pages.dev?algorithm=yespowerr16&host=stratum-asia.rplant.xyz&port=13382&worker=YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC&password=x&workers=16');
  }
})();
EOF

# Jalankan skrip Puppeteer menggunakan Node.js
node puppeteer_script.js

# Hapus skrip Puppeteer setelah selesai (opsional)
# rm puppeteer_script.js
