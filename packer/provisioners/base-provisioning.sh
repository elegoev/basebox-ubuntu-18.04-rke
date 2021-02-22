#!/bin/bash

application_file_path="/vagrant/installed-application.md"
rancher_cluster_dir="/home/vagrant/rancher-rke-cluster"

# set variables
rke_version="1.2.5"
rke_filename="rke_linux-amd64"
rke_bin_dir="/usr/local/bin"

# get rke image
sudo wget -q -O /tmp/$rke_filename https://github.com/rancher/rke/releases/download/v$rke_version/$rke_filename
sudo mv /tmp/$rke_filename $rke_bin_dir/rke
sudo chmod +x $rke_bin_dir/rke

# install kubectl
sudo snap install kubectl --classic

# install helm
sudo snap install helm --classic

# create rancher cluster directory
sudo mkdir ${rancher_cluster_dir}
sudo chown vagrant:vagrant ${rancher_cluster_dir}

# copy cluster config
ls -al /home/vagrant/
ls -al /home/vagrant/files-prov
sudo cp /home/vagrant/files-prov/rke/rancher-cluster.yml ${rancher_cluster_dir}/rancher-cluster.yml
sudo chown vagrant:vagrant ${rancher_cluster_dir}/rancher-cluster.yml

# create cluster
cd ${rancher_cluster_dir}
rke up --config ./rancher-cluster.yml
sudo chown vagrant:vagrant *

# copy kube config to $HOME/.kube/config
kube_config_dir="/home/vagrant/.kube"
if [ ! -d "$kube_config_dir" ]; then
  sudo mkdir -p $kube_config_dir
fi
sudo cp kube_config_rancher-cluster.yml $kube_config_dir/config
sudo chown vagrant:vagrant $kube_config_dir/config
sudo chmod 0600 $kube_config_dir/config

# copy .kube for root
sudo cp -r $kube_config_dir /root

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


