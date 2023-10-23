#Disable firewall
netsh advfirewall set allprofiles state off

#Show firewall settings
# netsh advfirewall show all


#Install python and git
winget install -e --id Python.Python.3.11 -s winget
winget install -e --id Git.Git -s winget

#Install nginx
$_nginxVersion = "nginx-1.25.2"
Invoke-WebRequest "https://nginx.org/download/$_nginxVersion.zip" -OutFile "$HOME\nginx.zip"
Expand-Archive "$HOME\nginx.zip" "$HOME\nginx" -Force
Test-Path "$HOME\nginx\$_nginxVersion\nginx.exe"


#Clone this repo
git clone https://github.com/shyguyCreate/ec2-flask "$HOME"

#Create and activate virtual environment
python -m venv "$HOME\ec2-flask\.venv"
"$HOME\ec2-flask\.venv\bin\Activate.ps1"

#Install program dependencies
pip install -r requirements.txt
