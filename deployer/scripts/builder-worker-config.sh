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
