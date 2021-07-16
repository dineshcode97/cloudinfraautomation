#!/bin/bash

sudo apt-get install nginx -y
sudo setenforce 0
sudo sudo apt-get install  apt-transport-https  ca-certificates  curl gnupg  lsb-release -y
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg,
sudo echo  deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl start docker
sudo systemctl enable docker
cat <<EOF | sudo tee /etc/nginx/sites-available/default
server {
        listen 80 default_server;
        listen [::]:80 default_server;
	root /var/www/html;
	index index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                proxy_pass http://localhost:8080;
        }
}
EOF
sudo systemctl restart nginx
