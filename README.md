# Flask in EC2 instances

Display a basic html website in an EC2 instance using NGINX to port the html contents to the internet in HTTP calls from the EC2 public IP address.

It also comes with support of Flask using Waitress WSGI server for deployment into localhost, NGINX reads the localhost IP and serves as a reverse proxy to show the html website in HTTP.

To use the python app, `cd` into directory of the repo, and run[^1]:

```
waitress-serve --listen 127.0.0.1:8080 app:app
```

The repo comes with configuration scripts for EC2 instance images for Amazon Linux, Ubuntu, and Windows. To use them, copy the script content inside the **User Data** section when creating the instance.

| AMI          | Script                                                       |
| ------------ | ------------------------------------------------------------ |
| Amazon Linux | [amazon_user-data.conf](./user-data/amazon-user_data.conf)   |
| Ubuntu       | [ubuntu_user-data.conf](./user-data/ubuntu-user_data.conf)   |
| Windows      | [windows_user-data.conf](./user-data/windows-user_data.conf) |

[^1]: Only in Windows, Nginx does not listen to waitress by default after running the windows config script, manual configutation is require. To to this, in the **nginx.conf** inside *C:\Users\Administrator*, set the content of the first **location** section to `proxy_pass http://127.0.0.1:8080;`.
