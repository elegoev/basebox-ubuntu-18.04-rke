#!/bin/bash

# set variables
RKE_VERSION="1.0.5"
RKE_FILENAME="rke_linux-amd64"
RKE_BINDIR="/usr/local/bin"

# get rke image
sudo wget -q -O /tmp/$RKE_FILENAME https://github.com/rancher/rke/releases/download/v$RKE_VERSION/$RKE_FILENAME
sudo mv /tmp/$RKE_FILENAME $RKE_BINDIR/rke
sudo chmod +x $RKE_BINDIR/rke

# create date string
DATE=`date +%Y%m%d%H%M`

# get rke version
RKE_INST_VERSION=$(rke --version | awk  '{print $3}' | tr --delete v)
echo "rke-$RKE_INST_VERSION" > /vagrant/version
