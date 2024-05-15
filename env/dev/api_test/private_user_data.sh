#!/bin/bash
sudo yum install -y https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm
sudo yum update -y
sudo yum install nginx -y

# index.htmlファイルを更新
sudo sed -i 's/Welcome to nginx!/Welcome to nginx! [private]/g' /usr/share/nginx/html/index.html

sudo systemctl start nginx
sudo systemctl enable nginx