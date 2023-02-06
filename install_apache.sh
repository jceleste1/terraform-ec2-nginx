#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
echo "Hello World Aqui e nginx AWS" > /var/www/html/index.html