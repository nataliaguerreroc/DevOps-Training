#!/bin/bash

if [ ! -f "/etc/systemd/system/redis.service" ]; then
	echo "redis doesnt exist"
	sudo apt-get update
	sudo apt-get upgrade -y

	wget https://download.redis.io/releases/redis-3.0.0.tar.gz

	tar xvzf redis-3.0.0.tar.gz
	cd redis-3.0.0

    sudo apt install make
	sudo make install
	make distclean;make
	sudo apt install -y redis-server

	sed -i 's/^bind 127.0.0.1 ::1$/bind 10.0.0.3/' /etc/redis/redis.conf 
	sed -i 's/^port 6379/port 6377/g' /etc/redis/redis.conf

	sudo systemctl restart redis
else
	echo "redis exists"
fi

if sudo systemctl is-active redis.service; then
    echo "redis-server is already on"
else
	echo "Starting redis"
	sudo service redis-server start
	#echo "Status redis"
	#sudo service redis-server status
fi

