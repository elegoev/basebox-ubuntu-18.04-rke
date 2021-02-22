#!/bin/bash

# set color
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

server_hostname=$(hostname)

local_ssh_path="/home/vagrant/.ssh"
root_ssh_path="/root/.ssh"
ssh_privkey_filename="id_rsa"
ssh_pubkey_filename="id_rsa.pub"
ssh_authorized_keys="authorized_keys"
ssh_known_hosts="known_hosts"

# create ssh key
sudo ssh-keygen -t rsa -C "developer@test.org" -b 4096 -N "" -f $local_ssh_path/$ssh_privkey_filename
sudo chmod 600 $local_ssh_path/$ssh_privkey_filename
sudo chmod 644 $local_ssh_path/$ssh_pubkey_filename

# add public key to authorized keys
sudo cat $local_ssh_path/$ssh_pubkey_filename >> $local_ssh_path/$ssh_authorized_keys

# add known host
sudo ssh-keyscan -H localhost >> $local_ssh_path/$ssh_known_hosts

# set ownership
sudo chown -R vagrant:vagrant $local_ssh_path

# copy ssh key for root
if [ -d "$root_ssh_path" ]
then
  sudo rm -fr $root_ssh_path
fi
sudo cp -r $local_ssh_path /root
