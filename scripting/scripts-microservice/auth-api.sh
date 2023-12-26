#!/bin/bash

cd
sudo apt install curl
curl -O https://storage.googleapis.com/golang/go1.11.2.linux-amd64.tar.gz
tar -xvf go1.11.2.linux-amd64.tar.gz
sudo mv go /usr/local

echo 'export GOPATH=$HOME/work' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.bashrc
source ~/.bashrc

echo "El script se detiene por 30s"
sleep 30

cd microservice-app-example/auth-api

export GO111MODULE=on
go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api
go mod tidy
sudo apt-get install build-essential
go build

JWT_SECRET=PRFT
AUTH_API_PORT=8000

export JWT_SECRET AUTH_API_PORT
USERS_API_ADDRESS=http://127.0.0.1:8083 ./auth-api


