#!/bin/bash

application_file_path="/vagrant/installed-application.md"


# set version
DOCKER_VERSION=$(sudo docker version --format '{{.Server.Version}}')
HELM_VERSION=$(sudo snap info helm | grep installed | awk  '{print $2}')
echo "# Installed application "  > $application_file_path
echo "***                     " >> $application_file_path
echo "> Docker: $DOCKER_VERSION" >> $application_file_path
echo "> Helm: $HELM_VERSION" >> $application_file_path
echo "> k3s: $K3S_VERSION" >> $application_file_path


