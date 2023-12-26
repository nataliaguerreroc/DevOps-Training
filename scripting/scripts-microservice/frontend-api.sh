#!/bin/bash

cd
sudo apt-get upgrade
cd microservice-app-example/frontend
rm -rf node_modules package-lock.json
sudo apt install npm


npm install
npm run build

PORT=8080
export PORT

AUTH_API_ADDRESS=http://127.0.0.1:8000 TODOS_API_ADDRESS=http://127.0.0.1:8082 npm start
