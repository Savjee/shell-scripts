#!/bin/bash
# Purpose: Update all lxc vms
# Note: Tested on Ubuntu LTS only
# Author: Vivek Gite <www.cyberciti.biz>, under GPL v2+
# -------------------------------------------------------

# Get the vm list
vms="$(lxc-ls --active)"

# Update each vm
update_vm(){
        local vm="$1"
        echo "*** [VM: $vm [$(hostname) @ $(date)] ] ***"
        /usr/bin/lxc-attach -n "$vm" apt-get -- -qq update
        /usr/bin/lxc-attach -n "$vm" apt-get -- -qq -y upgrade
        /usr/bin/lxc-attach -n "$vm" apt-get -- -qq -y clean
        /usr/bin/lxc-attach -n "$vm" apt-get -- -qq -y autoclean
        echo "-----------------------------------------------------------------"
}

# Do it
for v in $vms
do
   update_vm "$v"
done