#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
cat <<EOT >> /tmp/index.html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx website built with EC2 Userdata Demo!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx website built with EC2 Userdata Demo!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
EOT
sudo cp /tmp/index.html /var/www/html/index.nginx-debian.html