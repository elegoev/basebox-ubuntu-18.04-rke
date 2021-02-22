#!/bin/bash

if [ -n "$1" ]; then
  box_name=""
else
  box_name=$1
fi

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

# copy cluste config
sudo cp /home/vagrant/files-prov/rke/rancher-cluster.yml ${rancher_cluster_dir}/rancher-cluster.yml
sudo chown vagrant:vagrant ${rancher_cluster_dir}/rancher-cluster.yml

# copy private key
echo ">>>>> boxname = ${box_name}"
local_ssh_path="/home/vagrant/.ssh"
ssh_source_key="/vagrant/.vagrant/machines/${box_name}/virtualbox/private_key"
ssh_privkey_filename="id_rsa"
ssh_authorized_key="authorized_keys"
sudo cp $ssh_source_key $local_ssh_path/$ssh_privkey_filename
sudo chown vagrant:vagrant $local_ssh_path/$ssh_privkey_filename
sudo chmod 600 $local_ssh_path/$ssh_privkey_filename
sudo chown vagrant:vagrant $local_ssh_path/$SSHPRIVKEYFILENAME
sudo cat $local_ssh_path/$ssh_privkey_filename >> $local_ssh_path/$ssh_authorized_key

# copy .ssh for root
sudo cp -r $local_ssh_path /root

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


