#!/bin/sh

# Install OpenJDK
apt install openjdk-8-jdk -y

# Install Terraform
apt install unzip -y
wget https://releases.hashicorp.com/terraform/1.0.4/terraform_1.0.4_linux_amd64.zip
unzip terraform_1.0.4_linux_amd64.zip
chown jenkins_admin:jenkins_admin terraform
mv terraform /usr/local/bin/

# Add the Jenkins user
useradd -m -s /bin/bash jenkins
