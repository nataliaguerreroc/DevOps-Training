#!/bin/bash

cd
if ! command -v pip3 &>/dev/null; then
	sudo apt-get upgrade
	sudo apt-get update

	sudo apt install -y python3-pip
fi

cd microservice-app-example/log-message-processor

pip3 install -r requirements.txt

REDIS_HOST=127.0.0.1 REDIS_PORT=6379 REDIS_CHANNEL=log_channel python3 main.py
