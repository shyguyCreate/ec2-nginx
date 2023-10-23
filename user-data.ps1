#Install python and git
winget install -e --id Python.Python.3.11 -s winget
winget install -e --id Git.Git -s winget

#Clone this repo
git clone https://github.com/shyguyCreate/ec2-flask "$HOME"

#Create and activate virtual environment
python -m venv "$HOME\ec2-flask\.venv"
"$HOME\ec2-flask\.venv\bin\Activate.ps1"

#Install program dependencies
pip install -r requirements.txt
