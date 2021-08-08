#!/bin/sh

# Install OpenJDK and Jenkins
apt install openjdk-8-jdk -y
wget -qO - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update && apt-get install jenkins -y

# Install Terraform
apt install unzip -y
wget https://releases.hashicorp.com/terraform/1.0.4/terraform_1.0.4_linux_amd64.zip
unzip terraform_1.0.4_linux_amd64.zip
chown jenkins_admin:jenkins_admin terraform
mv terraform /usr/local/bin/

service jenkins restart
