#!/bin/sh
# For reference: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-upload-centos#centos-70

# Deprovision the machine
rm -rf /var/lib/waagent/
rm -f /var/log/waagent.log

waagent -force -deprovision+user
rm -f ~/.bash_history

export HISTSIZE=0
