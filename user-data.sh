#!/bin/bash

#Install python, git, ssh, nginx
sudo apt update
sudo apt -y install python3
sudo apt -y install python3-venv
sudo apt -y install git
sudo apt -y install openssh-server
sudo apt -y install nginx

#Enable ssh protocol in firewall
sudo ufw allow ssh

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
sudo rm /etc/nginx/sites-enabled/*

#Set nginx config
sudo cp "$HOME/ec2-flask/ec2-flask.conf" /etc/nginx/sites-available
sudo ln -sf /etc/nginx/sites-available/ec2-flask.conf /etc/nginx/sites-enabled

#Reload nginx
sudo systemctl restart nginx
