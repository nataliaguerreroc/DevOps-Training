#!/bin/bash

cd
sudo apt-get upgrade
sudo apt-get update

sudo apt install python3-pip

cd microservice-app-example/log-message-processor

pip3 install -r requirements.txt

REDIS_HOST=127.0.0.1 REDIS_PORT=6379 REDIS_CHANNEL=log_channel python3 main.py
