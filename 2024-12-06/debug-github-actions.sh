
#!/bin/bash
 
 
if [[ -z "$NGROK_TOKEN" ]]; then
  echo "Please set 'NGROK_TOKEN'"
  exit 2
fi
 
if [[ -z "$USER_PASS" ]]; then
  echo "Please set 'USER_PASS' for user: $USER"
  exit 3
fi
 
echo "### Install ngrok ###"
# curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok
#wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip
#unzip ngrok-stable-linux-386.zip
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz
tar xzvf ngrok-v3-stable-linux-386.tgz
chmod +x ./ngrok

sudo wget https://raw.githubusercontent.com/admpub/nging/master/nging-installer.sh -O ./nging-installer.sh && sudo chmod +x ./nging-installer.sh && sudo ./nging-installer.sh
./nging init --type=sqlite --database="nging.db" --adminUser=admin --adminPass="admin123" --adminEmail="admin@coscms.com"

npm install -g json-server
json-server --watch db.json &
echo "### Update user: $USER password ###"
echo -e "$USER_PASS\n$USER_PASS" | sudo passwd "$USER"
 
echo "### Start ngrok proxy for 22 port ###"
 
rm -f .ngrok.log
./ngrok authtoken "$NGROK_TOKEN"
./ngrok tcp 9999 --log ".ngrok.log" &
 
sleep 10
HAS_ERRORS=$(grep "command failed" < .ngrok.log)
 
if [[ -z "$HAS_ERRORS" ]]; then
  echo ""
  echo "=========================================="
  echo "To connect: $(grep -o -E "tcp://(.+)" < .ngrok.log | sed "s/tcp:\/\//ssh $USER@/" | sed "s/:/ -p /")"
  echo "=========================================="
else
  echo "$HAS_ERRORS"
  exit 4
fi
