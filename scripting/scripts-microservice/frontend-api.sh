#!/bin/bash

cd
cd microservice-app-example/frontend

if ! command -v npm &>/dev/null; then
	sudo apt-get upgrade
	rm -rf node_modules package-lock.json
	sudo apt install -y npm
fi

npm install
npm run build

PORT=8080
export PORT

AUTH_API_ADDRESS=http://127.0.0.1:8000 TODOS_API_ADDRESS=http://127.0.0.1:8082 npm start
