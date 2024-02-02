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

if ! command -v nvm &> /dev/null; then
    echo "nvm doesnt exist"

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

else
    echo "nvm exist"
fi

if [ "$(node -v)" == "v8.17.0" ]; then
    echo "Node.js v. 8.17.0 exist"
else
    echo "Installing Node.js v 8.17.0."
    nvm install 8.17.0
fi

cd microservice-app-example/todos-api

if pgrep -f "npm start" &>/dev/null; then
    echo "todos-api is already on"
else
	echo "Starting todos-api"
	echo "Starting nohup"
		ZIPKIN_URL=http://10.0.0.8:9411/api/v2/spans JWT_SECRET=PRFT TODO_API_PORT=8082 REDIS_HOST=10.0.0.3 REDIS_PORT=6377 REDIS_CHANNEL=log_channel nohup npm start > /home/vagrant/microservice-app-example/todos-api/nohup.out &
fi

