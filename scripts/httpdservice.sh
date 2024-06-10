#!/bin/bash
yum update -y
yum install git httpd -y
systemctl start httpd
systemctl enable httpd
echo "Launching EC2 Instance using Terraform " > /var/www/html/index.html