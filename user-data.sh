#!/bin/bash

#Install python, git, ssh, nginx
sudo apt -y install python3
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
git clone https://github.com/shyguyCreate/ec2-flask "$HOME"

#Create and activate virtual environment
python -m venv "$HOME/ec2-flask/.venv"
source "$HOME/ec2-flask/.venv/bin/activate"

#Install program dependencies
pip install -r requirements.txt
