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

if ! command -v curl &>/dev/null; then
	sudo apt-get update
	sudo apt install -y curl
fi

cd microservice-app-example/todos-api
sudo rm -rf node_modules package-lock.json

if ! command -v npm &>/dev/null; then
	echo "npm doesnt exist"
    sudo apt-get update
	sudo apt install -y npm
else
    echo "npm exists"
fi

npm install

if pgrep -f "npm start" &>/dev/null; then
    echo "todos-api is already on"
else
	echo "Starting todos-api"
	echo "Starting nohup"
	ZIPKIN_URL=http://10.0.0.8:9411/api/v2/spans JWT_SECRET=PRFT TODO_API_PORT=8082 REDIS_HOST=10.0.0.3 REDIS_PORT=6377 REDIS_CHANNEL=log_channel nohup npm start > /home/vagrant/microservice-app-example/todos-api/nohup.out &
fi