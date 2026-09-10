#!/bin/bash

apt-get update -y
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Terraform EC2</title>
</head>
<body>
    <h1>Hello from Terraform EC2!</h1>
    <p>Environment: ${environment}</p>
    <p>Server bootstrapped using EC2 User Data.</p>
</body>
</html>
EOF
