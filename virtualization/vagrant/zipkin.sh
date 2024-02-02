#!/bin/bash

if ! command -v git &> /dev/null; then
	sudo apt-get update
    sudo apt-get install -y git
fi

if ! command -v curl &>/dev/null; then
	sudo apt-get update
	sudo apt install -y curl
fi

if ! command -v java &>/dev/null; then
	echo "Java doesnt exist"
	sudo apt-get update
    sudo apt install -y openjdk-17-jdk openjdk-17-jre
else
	echo "Java exists"
fi

if [ ! -f "/etc/systemd/system/zipkin.service" ]; then
	echo "zipkin doesnt exist"
	sudo apt-get update
	curl -sSL https://zipkin.io/quickstart.sh | bash -s
	echo "installing zipkin"

    sudo mkdir /opt/zipkin
    sudo mv zipkin.jar /opt/zipkin
    
    sudo groupadd -r zipkin
    sudo useradd -r -s /bin/false -g zipkin zipkin
    sudo chown -R zipkin:zipkin /opt/zipkin

    sudo tee "/etc/systemd/system/zipkin.service" > /dev/null <<EOF
# Zipkin System Service
[Unit]
Description=Manage Java service
Documentation=https://zipkin.io/

[Service]
WorkingDirectory=/opt/zipkin
ExecStart=/bin/java -Xms128m -Xmx256m -jar zipkin.jar
User=zipkin
Group=zipkin
Type=simple
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl daemon-reload
else
	echo "zipkin exists"
fi

if sudo systemctl is-active zipkin.service; then
	echo "zipkin is already on"
else
	echo "Starting zipkin"
	SERVER_PORT=9411 SERVER_ADDRESS=10.0.0.8 sudo systemctl start zipkin.service
fi


