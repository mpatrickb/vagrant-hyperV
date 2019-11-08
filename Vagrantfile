# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"
  config.vm.box_version = "1.0.282"
  
  config.vm.provider "hyperv" do |v, override|
    v.maxmemory = 3048
    v.memory = 2048
    v.cpus = 2
	v.enable_virtualization_extensions = true
  end

    config.ssh.forward_agent = true
    config.ssh.insert_key = false

    #config.ssh.forward_agent = true
    #config.ssh.username = "vagrant"
    #config.ssh.password = "vagrant"


  # config.vm.network "DockerNAT"

  config.vm.synced_folder "site", "/vagrant", type: "sshfs", sshfs_opts_append: "-o nonempty -o cache=no"

  # config.vm.synced_folder "site", "/vagrant", type: "smb",
  #  smb_password: "", smb_username: "",
  #   mount_options: ['vers=3.0']

	
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.provision :shell, path: "bootalways.sh", run: 'always'

end
