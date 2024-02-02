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

if ! command -v go &>/dev/null || ! go version | grep -q "1.11.2"; then
	echo "go doesnt exist"
	sudo apt-get update
	curl -O https://storage.googleapis.com/golang/go1.11.2.linux-amd64.tar.gz
	echo "installing go"

	tar -xvf go1.11.2.linux-amd64.tar.gz
    sudo rm -rf /usr/local/*
	sudo mv go /usr/local

	echo 'export GOPATH=$HOME/work' | sudo tee -a /etc/profile
	echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' | sudo tee -a /etc/profile
else
	echo "go exists"
fi

cd microservice-app-example/auth-api

export GO111MODULE=on
go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api
go mod tidy
sudo apt-get install -y build-essential
go build

if pgrep -f "auth-api" &>/dev/null; then
    echo "auth-api is already on"
else
	echo "Starting auth-api"
	echo "Starting nohup"
	ZIPKIN_URL=http://10.0.0.8:9411/api/v2/spans JWT_SECRET=PRFT AUTH_API_PORT=8000 USERS_API_ADDRESS=http://10.0.0.7:8083 nohup ./auth-api > /home/vagrant/microservice-app-example/auth-api/nohup.out &
fi