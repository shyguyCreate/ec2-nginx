#!/bin/bash

#Install python and git
sudo apt -y install python3
sudo apt -y install git

#Clone this repo
git clone https://github.com/shyguyCreate/ec2-flask "$HOME"

#Create and activate virtual environment
python -m venv "$HOME/ec2-flask/.venv"
source "$HOME/ec2-flask/.venv/bin/activate"

#Install program dependencies
pip install -r requirements.txt
