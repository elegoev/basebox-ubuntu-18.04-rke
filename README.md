# ubuntu-18.04-rke

Vagrant Box with Ubuntu 18.04 and rke

## Base image

Used base image [elegoev/ubuntu-18.04-docker](https://app.vagrantup.com/elegoev/boxes/ubuntu-18.04-docker)

## Directory Description

| directory | description                                          |
|-----------|------------------------------------------------------|
| inspec    | inspec test profiles with controls                   |
| packer    | packer build, provisioner and post-processor scripts |
| test      | test environment for provision & inspec development  |

## Vagrant

### Vagrant Cloud

- [elegoev/ubuntu-18.04-rke](https://app.vagrantup.com/elegoev/boxes/ubuntu-18.04-rke)

### Vagrant Plugins

- [vagrant-disksize](https://github.com/sprotheroe/vagrant-disksize)
- [vagrant-hosts](https://github.com/oscar-stack/vagrant-hosts)
- [vagrant-secret](https://github.com/tcnksm/vagrant-secret)
- [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)
- [vagrant-serverspec](https://github.com/vvchik/vagrant-serverspec)
- [vagrant-vmware-esxi](https://github.com/josenk/vagrant-vmware-esxi)

### Vagrantfile

    Vagrant.configure("2") do |config|

      ENV['VAGRANT_EXPERIMENTAL'] = "disks"

      $basebox_name="ubuntu-18.04-rke-test"
      $basebox_hostname="ubuntu-1804-rke-test"
      $src_image_name="elegoev/ubuntu-18.04-rke"
      $vb_group_name="basebox-rke-test"

      config.vm.define "#{$basebox_name}" do |machine|
        machine.vm.box = "#{$src_image_name}"
    
        # define guest hostname
        machine.vm.hostname = "#{$basebox_hostname}"

        machine.vm.provider "virtualbox" do |vb|
          vb.name = $basebox_name
          vb.cpus = 1
          vb.customize ["modifyvm", :id, "--memory", "1024" ]
          vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
          vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
          vb.customize ["modifyvm", :id, "--groups", "/#{$vb_group_name}" ]
          vb.customize ["modifyvm", :id, "--vram", 256 ]
        end

        machine.vm.disk :disk, size: "40GB", primary: true

      end   

    end

## RKE

### Help

    rke --help

## Referenzen

- [Rancher Kubernetes Engine (RKE)](https://rancher.com/products/rke/)
- [Github RKE](https://github.com/rancher/rke)
- [Creating a vSphere Cluster](https://rancher.com/docs/rancher/v2.x/en/cluster-provisioning/rke-clusters/node-pools/vsphere/)
- [K8s Ingress Controllers](https://rancher.com/docs/rke/latest/en/config-options/add-ons/ingress-controllers/)
- [Metallb kubernetes-rke-baremetal](https://github.com/mimizone/kubernetes-rke-baremetal/tree/master/metallb)

## Versioning

Repository follows sematic versioning  [![semantic versioning](https://img.shields.io/badge/semver-2.0.0-green.svg)](http://semver.org)

## Changelog

For all notable changes see [CHANGELOG](https://github.com/elegoev/basebox-ubuntu-18.04-rke/blob/master/CHANGELOG.md)

## License

Licensed under The MIT License (MIT) - for the full copyright and license information, please view the [LICENSE](https://github.com/elegoev/basebox-ubuntu-18.04-rke/blob/master/LICENSE) file.

## Issue Reporting

Any and all feedback is welcome.  Please let me know of any issues you may find in the bug tracker on github. You can find it [here.](https://github.com/elegoev/basebox-ubuntu-18.04-rke/issues)
