#!/bin/sh

# Install OpenJDK
apt install openjdk-8-jdk -y

# Install Terraform
apt install unzip -y
wget https://releases.hashicorp.com/terraform/1.0.4/terraform_1.0.4_linux_amd64.zip
unzip terraform_1.0.4_linux_amd64.zip
chown jenkins_admin:jenkins_admin terraform
mv terraform /usr/local/bin/

# Install az
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Add the Jenkins user
useradd -m -s /bin/bash jenkins

# Install azcopy
wget https://aka.ms/downloadazcopy-v10-linux
tar -zxvf downloadazcopy-v10-linux
cp azcopy_linux_amd64_10.11.0/azcopy /usr/local/bin/
rm -r downloadazcopy-v10-linux azcopy_linux_amd64_10.11.0
chown jenkins:jenkins /usr/local/bin/azcopy
