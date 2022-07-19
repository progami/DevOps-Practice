#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo '<center><h1>This EC2 Instance is in App Group B</h1></center>' > /var/www/html/index.txt
cp /var/www/html/index.txt /var/www/html/index.html