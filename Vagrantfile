# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # ubuntu
  config.vm.define "tp-docker-base" do |configtpdockerbase|
    configtpdockerbase.vm.box = "ubuntu/groovy64"
    configtpdockerbase.vm.hostname = "tp-docker-base"
    configtpdockerbase.vm.box_url = "ubuntu/groovy64"
    configtpdockerbase.vm.network :private_network, ip: "192.168.5.20"
    configtpdockerbase.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "tp-docker-base"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
      service ssh restart
    SHELL
    configtpdockerbase.vm.provision "shell", path: "install_docker_ubuntu.sh"
  end

end