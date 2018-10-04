# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  #-------------------------------------------------------------------------------
  # all server
  #-------------------------------------------------------------------------------
  config.vm.box = "centos/7"
  config.ssh.insert_key = false
  config.vm.provision "file", source: "~/.vagrant.d/insecure_private_key", destination: "~/.ssh/id_rsa"
  config.vm.provision "shell", inline: "sudo chmod 600 /home/vagrant/.ssh/id_rsa"
  config.vm.provision "shell", path: "./vagrant/provision_proxy.sh"

  #-------------------------------------------------------------------------------
  # work server
  #-------------------------------------------------------------------------------
  config.vm.define "work" do |wk|
    wk.vm.provider "virtualbox" do |vb|
      vb.gui = true  
      vb.memory = "512"

      # add strage
      file_to_disk = "./vagrant/glusterfs_work.vdi"
      unless File.exists?(file_to_disk)
        vb.customize ['createhd', '--filename', file_to_disk, '--size', 1 * 1024] # 1GB
      end
      vb.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
    end
    wk.vm.hostname = "work"
    wk.vm.network "private_network", ip: "172.16.33.11"
    wk.vm.provision "shell", path: "./vagrant/provision_ansible.sh"
  end

  #-------------------------------------------------------------------------------
  # kong server(kong + postgressSQL10)
  #-------------------------------------------------------------------------------
  config.vm.define "kong" do |hap|
    hap.vm.provider "virtualbox" do |vb|
      vb.gui = true  
      vb.memory = "2048"
    end
    hap.vm.hostname = "kong"
    hap.vm.network "private_network", ip: "172.16.33.12"
  end

  #-------------------------------------------------------------------------------
  # master server
  #-------------------------------------------------------------------------------
  (1..1).each do |i|
    config.vm.define "k8s-master#{i}" do |master|
      master.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.memory = "2048"

        # add strage
        file_to_disk = "./vagrant/glusterfs_mst#{i}.vdi"
        unless File.exists?(file_to_disk)
          vb.customize ['createhd', '--filename', file_to_disk, '--size', 1 * 1024] # 1GB
        end
        vb.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
      end
      master.vm.hostname = "k8s-master#{i}"
      master.vm.network "private_network", ip: "172.16.33.2#{i}"
    end
  end

  #-------------------------------------------------------------------------------
  # node server
  #-------------------------------------------------------------------------------
  (1..2).each do |i|
    config.vm.define "k8s-node#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.memory = "2048"

        # add strage
        file_to_disk = "./vagrant/glusterfs_node#{i}.vdi"
        unless File.exists?(file_to_disk)
          vb.customize ['createhd', '--filename', file_to_disk, '--size', 1 * 1024] # 1GB
        end
        vb.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
      end
      node.vm.hostname = "k8s-node#{i}"
      node.vm.network "private_network", ip: "172.16.33.3#{i}"
    end
  end
end
