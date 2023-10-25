#!/bin/bash

#Install python, git, ssh, nginx
sudo apt update
sudo apt -y install python3
sudo apt -y install python3-venv
sudo apt -y install git
sudo apt -y install openssh-server
sudo apt -y install nginx

#Add www-data to ubuntu user
sudo gpasswd -a www-data ubuntu

#Allow groups like www-data to read and execute into ubuntu HOME dir
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

#Remove default nginx config
default_conf_dir="/etc/nginx/sites-enabled"
sudo rm "$default_conf_dir"/*

#Set nginx config
sudo cp "$HOME/ec2-flask/ec2-flask.conf" /etc/nginx/sites-available
sudo sed -i "s,\$HOME,$HOME,g" /etc/nginx/sites-available/ec2-flask.conf
sudo ln -sf /etc/nginx/sites-available/ec2-flask.conf "$default_conf_dir"

#Copy index.html and image to default location
default_html_dir="/var/www/html"
sudo sed -i "s,\$default_html_dir,$default_html_dir,g" /etc/nginx/sites-available/ec2-flask.conf
sudo cp "$HOME/ec2-flask/nginx/index.html" "$default_html_dir"
sudo cp "$HOME/ec2-flask/nginx/equipo2.webp" "$default_html_dir"

#Reload nginx
sudo systemctl restart nginx
