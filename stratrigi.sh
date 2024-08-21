# Install necessary packages
sudo apt update
sudo apt install -y docker.io npm

# Create and set up the 'avi' directory
mkdir avi
cd avi

# Clone the repository twice into separate directories
git clone https://github.com/oneevil/stratum-ethproxy avi
git clone https://github.com/oneevil/stratum-ethproxy ques
git clone https://github.com/oneevil/stratum-ethproxy unf

# Set up and start the 'avi' instance
cd avi
npm install

# Set environment variables for 'avi'
LOCAL_IP=$(hostname -I | awk '{print $1}')
cat <<EOL >> .env
REMOTE_HOST=stratum-asia.rplant.xyz
REMOTE_PORT=17068
REMOTE_PASSWORD=x
LOCAL_HOST=$LOCAL_IP
LOCAL_PORT=443
EOL

# Start the stratum-ethproxy in a detached screen session with a specific name
sudo screen -dmS avi npm start

# Set up and start the 'quest' instance
cd ../ques
npm install

# Set environment variables for 'quest'
cat <<EOL >> .env
REMOTE_HOST=stratum-asia.rplant.xyz
REMOTE_PORT=17122
REMOTE_PASSWORD=x
LOCAL_HOST=$LOCAL_IP
LOCAL_PORT=80
EOL

# Start the stratum-ethproxy in a detached screen session with a specific name
sudo screen -dmS quest npm start

# Set up and start the 'quest' instance
cd ../unf
npm install

# Set environment variables for 'unfa'
cat <<EOL >> .env
REMOTE_HOST=stratum-asia.rplant.xyz
REMOTE_PORT=17116
REMOTE_PASSWORD=x
LOCAL_HOST=$LOCAL_IP
LOCAL_PORT=808
EOL

# Start the stratum-ethproxy in a detached screen session with a specific name
sudo screen -dmS unfa npm start
