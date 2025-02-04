# Install necessary packages
# sudo apt update
# sudo apt install -y docker.io npm 

# Clone the repository twice into separate directories
git clone https://github.com/oneevil/stratum-ethproxy bac

# Set up and start the 'gpu' instance
cd bac
npm install

# Set environment variables for 'gpu'
LOCAL_IP=$(hostname -I | awk '{print $1}')
cat <<EOL >> .env
REMOTE_HOST=stratum-asia.rplant.xyz
REMOTE_PORT=17116
REMOTE_PASSWORD=x
LOCAL_HOST=$LOCAL_IP
LOCAL_PORT=843
EOL

# Start the stratum-ethproxy in a detached screen session with a specific name
sudo screen -dmS bac npm start
 
