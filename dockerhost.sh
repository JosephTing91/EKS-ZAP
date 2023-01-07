#!/bin/bash
# Hardware requirements: AWS Linux 2 with mimum t2.micro type instance & port 8080(application port), 9100 (node-exporter port) should be allowed on the security groups
# setup for the ansible configuration
sudo yum update –y
sudo useradd dockeradmin
sudo passwd dockeradmin
sudo echo dockeradmin:dockeradmin | chpasswd
sudo sed -i "s/.*PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo service sshd restart

sudo yum install docker -y
service docker start




docker pull tomcat
docker run -d --name tomcat-container -p 8081:8080 tomcat
cp -R * ../webapps/