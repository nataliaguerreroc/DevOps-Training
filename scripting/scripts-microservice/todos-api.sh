#!/bin/bash

cd
sudo apt-get update
sudo apt install npm
cd microservice-app-example/todos-api
rm -rf node_modules package-lock.json

npm install

JWT_SECRET=PRFT
TODO_API_PORT=8082

export JWT_SECRET TODO_API_PORT
npm start
