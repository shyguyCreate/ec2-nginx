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
git clone https://github.com/shyguyCreate/ec2-flask "$HOME\ec2-flask"

#Create and activate virtual environment
python -m venv "$HOME\ec2-flask\.venv"
"$HOME\ec2-flask\.venv\bin\Activate.ps1"

#Install program dependencies
pip install -r "$HOME\ec2-flask\requirements.txt"


#Remove default nginx config
Remove-Item C:\nginx\conf\sites-enabled\* -Force

#Set nginx config
Copy-Item "$HOME\ec2-flask\nginx\ec2-flask.conf" C:\nginx\conf\sites-available
(Get-Content C:\nginx\conf\sites-available\ec2-flask.conf).Replace("`$HOME", "$HOME") > C:\nginx\conf\sites-available\ec2-flask.conf
New-Item -Value C:\nginx\conf\sites-available\ec2-flask.conf -Path C:\nginx\conf\sites-enabled -ItemType SymbolicLink -Force

#Reload nginx
nginx -s reload
