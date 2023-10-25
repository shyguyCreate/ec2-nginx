#!/bin/bash

#Install python, git, ssh, nginx
sudo dnf check-update --releasever=latest
sudo dnf install -y python3
sudo dnf install -y git
sudo dnf install -y openssh
sudo dnf install -y nginx

#Add nginx to ec2-user user
sudo gpasswd -a nginx ec2-user

#Allow groups like nginx to read and execute into ec2-user HOME dir
chmod 750 "$HOME"

#Enable/start ssh
sudo systemctl enable --now ssh

#Enable/start nginx
sudo systemctl enable --now nginx

#Clone this repo
git clone https://github.com/shyguyCreate/ec2-flask "$HOME/ec2-flask"

#Create and activate virtual environment
python3 -m venv "$HOME/ec2-flask/.venv"
source "$HOME/ec2-flask/.venv/bin/activate"

#Install program dependencies
pip install -r "$HOME/ec2-flask/requirements.txt"

#Nginx configuration variables
default_conf_dir="/etc/nginx/conf.d"
default_html_dir="/usr/share/nginx/html"
repo_html_dir="$HOME/ec2-flask/nginx"

#Remove default nginx config
sudo rm "$default_conf_dir"/*

#Copy index.html and image to default location
sudo cp "$repo_html_dir/index.html" "$default_html_dir"
sudo cp "$repo_html_dir/equipo2.webp" "$default_html_dir"

#Set nginx config
sudo cp "$HOME/ec2-flask/ec2-flask.conf" "$default_conf_dir"
sudo sed -i "s,\$repo_html_dir,$repo_html_dir,g" "$default_conf_dir/ec2-flask.conf"
sudo sed -i "s,\$default_html_dir,$default_html_dir,g" "$default_conf_dir/ec2-flask.conf"

#Reload nginx
sudo systemctl restart nginx
