#!/bin/bash

if ! command -v git &> /dev/null; then
	sudo apt-get update
    sudo apt-get install -y git
fi

if [ ! -d "microservice-app-example" ]; then
	echo "microservice app doesnt exist"
	git clone https://github.com/nataliaguerreroc/microservice-app-example.git
else
	echo "microservice app exist"
fi

cd microservice-app-example/frontend
sudo rm -rf node_modules package-lock.json

if ! command -v npm &>/dev/null; then
	echo "npm doesnt exist"
    sudo apt-get update
	sudo apt install -y npm
fi

npm install
npm run build

if pgrep -f "npm start" &>/dev/null; then
    echo "frontend is already on"
else
	echo "Starting frontend"
	echo "Starting nohup"
	ZIPKIN_URL=http://10.0.0.8:9411/api/v2/spans PORT=8080 AUTH_API_ADDRESS=http://10.0.0.2:8000 TODOS_API_ADDRESS=http://10.0.0.4:8082 nohup npm start > /home/vagrant/microservice-app-example/frontend/nohup.out &
fi

