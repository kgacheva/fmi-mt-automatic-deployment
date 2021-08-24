#!/bin/sh

# Set SELinux to permissive and stop the firewall
setenforce 0
systemctl stop firewalld

# Install packer
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum install -y packer

# Install supplementary packages
yum -y install epel-release
yum install -y qemu-kvm htop screen dnf git

# Copy the qemu-kvm exec to the name expected by Packer
cp /usr/libexec/qemu-kvm /usr/libexec/qemu-system-x86_64

# Install azcopy
wget https://aka.ms/downloadazcopy-v10-linux
tar -zxvf downloadazcopy-v10-linux
cp azcopy_linux_amd64_10.11.0/azcopy /usr/libexec
rm -r downloadazcopy-v10-linux azcopy_linux_amd64_10.11.0
sudo chown packer_admin:packer_admin /usr/libexec/azcopy

# Install az
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
cat << EOF > /etc/yum.repos.d/azure-cli.repo
[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc"
EOF
dnf install -y azure-cli

# Add /usr/libexec to the PATH of the packer_admin user
echo 'export PATH=$PATH:/usr/libexec' >> /home/packer_admin/.bashrc

# Add packer_admin to the kvm group
usermod -aG kvm packer_admin

# Accept a number of system env variables when sent over SSH
cat << EOF >> /etc/ssh/sshd_config
AcceptEnv PKR_VAR_templ_ssh_password PKR_VAR_templ_depl_environment
AcceptEnv TEMPL_OS_VER_TYPE TEMPL_GIT_URL
EOF
systemctl reload sshd
