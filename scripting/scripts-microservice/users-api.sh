#!/bin/bash

cd
sudo apt-get update
sudo apt install openjdk-8-jdk

echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' | sudo tee -a /etc/profile
echo 'export JAVA_HOME' | sudo tee -a /etc/profile
echo 'export PATH=$PATH:$JAVA_HOME/bin' | sudo tee -a /etc/profile

sudo apt install maven

cd microservice-app-example/users-api

./mvnw clean install


JWT_SECRET=PRFT
SERVER_PORT=8083

export JWT_SECRET SERVER_PORT
java -jar target/users-api-0.0.1-SNAPSHOT.jar
