#!/bin/sh
# For reference: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-upload-centos#centos-70

# Deprovision the machine
sudo rm -rf /var/lib/waagent/
sudo rm -f /var/log/waagent.log

waagent -force -deprovision+user
rm -f ~/.bash_history

export HISTSIZE=0

logout
