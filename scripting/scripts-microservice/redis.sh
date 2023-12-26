#!/bin/bash

cd

sudo apt-get update
sudo apt-get upgrade

wget https://download.redis.io/releases/redis-3.0.0.tar.gz

tar xvzf redis-3.0.0.tar.gz
cd redis-3.0.0
sudo make install
make distclean;make
sudo apt install redis-server


sudo service redis-server start
sudo service redis-server status

