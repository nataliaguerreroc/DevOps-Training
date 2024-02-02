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

if ! command -v java &>/dev/null || ! java -version 2>&1 | grep -q "1.8"; then
	echo "Java doesnt exist"
	sudo apt-get update
	sudo apt install -y openjdk-8-jdk

	echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' | sudo tee -a /etc/profile
	echo 'export JAVA_HOME' | sudo tee -a /etc/profile
	echo 'export PATH=$PATH:$JAVA_HOME/bin' | sudo tee -a /etc/profile
else
	echo "Java exists"
fi

if ! command -v mvn &>/dev/null; then
	echo "mvn doesnt exist"
	sudo apt-get update
	sudo apt install -y maven
fi

cd microservice-app-example/users-api

./mvnw clean install

if pgrep -f "java -jar target/users-api-0.0.1-SNAPSHOT.jar" &>/dev/null; then
	echo "users_api is already on"
else
	echo "Starting users-api"
	echo "Starting nohup"
	SPRING_ZIPKIN_BASE_URL=http://10.0.0.8:9411 JWT_SECRET=PRFT SERVER_PORT=8083 nohup java -jar target/users-api-0.0.1-SNAPSHOT.jar > /home/vagrant/microservice-app-example/users-api/nohup.out &
fi

