#!/bin/bash

cd

if ! command -v java &>/dev/null || ! java -version 2>&1 | grep -q "1.8"; then
	sudo apt-get update
	sudo apt install -y openjdk-8-jdk

	echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' | sudo tee -a /etc/profile
	echo 'export JAVA_HOME' | sudo tee -a /etc/profile
	echo 'export PATH=$PATH:$JAVA_HOME/bin' | sudo tee -a /etc/profile
fi

if ! command -v mvn &>/dev/null; then
	sudo apt-get update
	sudo apt install maven
fi


cd microservice-app-example/users-api

./mvnw clean install


JWT_SECRET=PRFT
SERVER_PORT=8083

export JWT_SECRET SERVER_PORT
java -jar target/users-api-0.0.1-SNAPSHOT.jar
