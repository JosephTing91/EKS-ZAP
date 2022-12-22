#!/bin/bash
sudo yum update -yum
sudo su -i
#update aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#download kubectl
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.7/2022-10-31/bin/linux/amd64/kubectl

chmod +x kubectl
mv kubectl /usr/local/bin

#eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
export PATH=$PATH:/usr/local/bin

#ansible
sudo yum update –y
sudo useradd ansadmin
sudo passwd ansadmin
sudo echo ansadmin:ansadmin | chpasswd
sudo sed -i "s/.*PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo service sshd restart
sudo echo "%wheel  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sudo service sshd restart
sudo usermod -aG wheel ansadmin
