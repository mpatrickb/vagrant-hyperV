# vagrant-hyperV

Get started with Vagrant and the Hyper-V provider. This build contains the following package:
- Ubuntu
- php7.2
- mysql
- phpmyadmin
- composer
- git
- symfony

Default username and password:
**vagrant / vagrant**

## Usage
```Shell
git clone https://github.com/mpatrickb/vagrant-hyperV.git ./
vagrant up
```


### Userfull
- IP is always saved here > ```/vagrant/ipaddress```
- Apache2 uses the following location: ```\var\www\html\```
- Use SFTP in phpstorm. Root path: ```/var/www``` or ```/var/www/html```
- If you want to clone a private repository from github, note your credentials,etc into /vagrant/GIT and run ```/vagrant/gitclone.sh``` in the vagrant box.
- Symfony needs this: ```composer require symfony/apache-pack```

---

## Setup Vagrant
1) [Download](https://www.vagrantup.com/downloads.html) and install 
2) Open powershell
```PowerShell
vagrant plugin install vagrant-sshfs
```

## Setup Hyper-V and OpenSSH-server

1) Open powershell (as admin)
```PowerShell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
```
> *don't reboot yet*

### Add correct permissions for useraccount
1) Start > run: lusrmgr.msc
2) Groeps > open: Hyper-V-administrators
3) Add your account as member to this group
4) Reboot

### Configure network
1) Start > run: virtmgmt.msc
2) Select 'Virtual Switch Manager'
3) New virtual networkswitch
4) Give it a name and select the right external network adapter

### Errors
- Sftp error; Please run in powershell (as admin)
```PowerShell
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```
