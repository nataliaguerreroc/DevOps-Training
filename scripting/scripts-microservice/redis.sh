#!/bin/bash

cd

if [ "$(redis-server --version | awk '{print $3}')" != "v=3.0.0" ]; then
	sudo apt-get update
	sudo apt-get upgrade -y

	wget https://download.redis.io/releases/redis-3.0.0.tar.gz

	tar xvzf redis-3.0.0.tar.gz
	cd redis-3.0.0
	sudo make install
	make distclean;make
	sudo apt install -y redis-server
fi

sudo service redis-server start
sudo service redis-server status

