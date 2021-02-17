#!/bin/bash

application_file_path="/vagrant/installed-application.md"

# set variables
RKE_VERSION="1.2.5"
RKE_FILENAME="rke_linux-amd64"
RKE_BINDIR="/usr/local/bin"

# get rke image
sudo wget -q -O /tmp/$RKE_FILENAME https://github.com/rancher/rke/releases/download/v$RKE_VERSION/$RKE_FILENAME
sudo mv /tmp/$RKE_FILENAME $RKE_BINDIR/rke
sudo chmod +x $RKE_BINDIR/rke

# get rke version
echo "rke-$RKE_INST_VERSION" > /vagrant/version

# install kubectl
sudo snap install kubectl --classic

# install helm
sudo snap install helm --classic

# set version
DOCKER_VERSION=$(sudo docker version --format '{{.Server.Version}}')
KUBECTL_VERSION=$(sudo snap info kubectl | grep installed | awk  '{print $2}')
HELM_VERSION=$(sudo snap info helm | grep installed | awk  '{print $2}')
RKE_VERSION=$(rke --version | awk  '{print $3}' | tr --delete v)
echo "# Installed application "  > $application_file_path
echo "***                     " >> $application_file_path
echo "> Docker: $DOCKER_VERSION" >> $application_file_path
echo "> Kubectl: $KUBECTL_VERSION" >> $application_file_path
echo "> Helm: $HELM_VERSION" >> $application_file_path
echo "> rke: $RKE_VERSION" >> $application_file_path


