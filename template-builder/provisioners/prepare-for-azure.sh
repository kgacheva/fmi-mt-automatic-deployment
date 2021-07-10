#!/bin/sh
# For reference: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-upload-centos#centos-70

cat >> /etc/sysconfig/network << EOF
    NETWORKING=yes
    HOSTNAME=localhost.localdomain
EOF

cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
    DEVICE=eth0
    ONBOOT=yes
    BOOTPROTO=dhcp
    TYPE=Ethernet
    USERCTL=no
    PEERDNS=yes
    IPV6INIT=no
    NM_CONTROLLED=no
EOF

# echo  "S0:12345:respawn:/sbin/agetty -L 115200 console vt102" >> /etc/inittab

ln -s /dev/null /etc/udev/rules.d/75-persistent-net-generator.rules

cat > /etc/yum.repos.d/CentOS-Base.repo << EOF
[openlogic]
name=CentOS-$releasever - openlogic packages for $basearch
baseurl=http://olcentgbl.trafficmanager.net/openlogic/$releasever/openlogic/$basearch/
enabled=1
gpgcheck=0

[base]
name=CentOS-$releasever - Base
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
baseurl=http://olcentgbl.trafficmanager.net/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates
[updates]
name=CentOS-$releasever - Updates
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates&infra=$infra
baseurl=http://olcentgbl.trafficmanager.net/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra
baseurl=http://olcentgbl.trafficmanager.net/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus&infra=$infra
baseurl=http://olcentgbl.trafficmanager.net/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF

sudo yum clean all
sudo yum -y update

sed -i 's/GRUB_CMDLINE_LINUX=".*"/GRUB_CMDLINE_LINUX="rootdelay=300 console=ttyS0 earlyprintk=ttyS0 net.ifnames=0 " /' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

echo 'add_drivers+=" hv_vmbus hv_netvsc hv_storvsc "' >> /etc/dracut.conf
dracut -f -v

yum install -y python-pyasn1 WALinuxAgent

systemctl enable waagent

yum install -y cloud-init cloud-utils-growpart gdisk hyperv-daemons

# Configure waagent for cloud-init
sed -i 's/Provisioning.UseCloudInit=n/Provisioning.UseCloudInit=y/g' /etc/waagent.conf
sed -i 's/Provisioning.Enabled=y/Provisioning.Enabled=n/g' /etc/waagent.conf

echo "Adding mounts and disk_setup to init stage"
sed -i '/ - mounts/d' /etc/cloud/cloud.cfg
sed -i '/ - disk_setup/d' /etc/cloud/cloud.cfg
sed -i '/cloud_init_modules/a\\ - mounts' /etc/cloud/cloud.cfg
sed -i '/cloud_init_modules/a\\ - disk_setup' /etc/cloud/cloud.cfg

echo "Allow only Azure datasource, disable fetching network setting via IMDS"
cat > /etc/cloud/cloud.cfg.d/91-azure_datasource.cfg <<EOF
datasource_list: [ Azure ]
datasource:
Azure:
    apply_network_config: False
EOF

if [[ -f /mnt/resource/swapfile ]]; then
echo Removing swapfile - RHEL uses a swapfile by default
swapoff /mnt/resource/swapfile
rm /mnt/resource/swapfile -f
fi

echo "Add console log file"
cat >> /etc/cloud/cloud.cfg.d/05_logging.cfg << EOF

# This tells cloud-init to redirect its stdout and stderr to
# 'tee -a /var/log/cloud-init-output.log' so the user can see output
# there without needing to look on the console.
output: {all: '| tee -a /var/log/cloud-init-output.log'}
EOF

sed -i 's/ResourceDisk.Format=y/ResourceDisk.Format=n/g' /etc/waagent.conf
sed -i 's/ResourceDisk.EnableSwap=y/ResourceDisk.EnableSwap=n/g' /etc/waagent.conf

# Deprovision the machine
sudo rm -rf /var/lib/waagent/
sudo rm -f /var/log/waagent.log

waagent -force -deprovision+user
rm -f ~/.bash_history

export HISTSIZE=0

logout
