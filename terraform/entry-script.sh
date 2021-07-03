#!/bin/bash
sudo apt-get update -y && sudo apt-get install -y docker.io
sudo systemctl start docker
sudo usermod -aG docker ubuntu
docker run -p 8080:80 nginx

#install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
