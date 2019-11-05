# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"
  config.vm.box_version = "1.0.282"
  config.vm.provider "hyperv" do |v, override|
    #v.maxmemory = 2048
    v.memory = 3048
    v.cpus = 2
	v.enable_virtualization_extensions = true
  end
  # config.vm.network "DockerNAT"
  
  #config.vm.synced_folder ".", "/vagrant", disabled: false
  config.vm.synced_folder "site", "/vagrant", type: "smb",
    smb_password: "", smb_username: "",
	mount_options: ['vers=3.0']
	
  #config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=774','fmode=775']
	
  config.vm.provision :shell, path: "bootstrap.sh"
  #config.vm.provision :shell, path: "bootalways.sh", run: 'always'
  
  # config.vm.network "forwarded_port", guest: 80, host: 8765

end
