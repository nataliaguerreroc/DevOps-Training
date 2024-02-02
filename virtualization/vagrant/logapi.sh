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

if ! command -v pip3 &>/dev/null; then
	echo "pip3 doesnt exist"
	sudo apt-get upgrade
	sudo apt-get update

	sudo apt install -y python3-pip
fi

cd microservice-app-example/log-message-processor

pip3 install -r requirements.txt

if pgrep -f "python3 main.py" &>/dev/null; then
	echo "log_api is already on"
else
	echo "Starting log-api"
	echo "Starting nohup"
	ZIPKIN_URL=http://10.0.0.8:9411/api/v2/spans REDIS_HOST=10.0.0.3 REDIS_PORT=6377 REDIS_CHANNEL=log_channel nohup python3 main.py > /home/vagrant/microservice-app-example/log-message-processor/nohup.out &
fi

