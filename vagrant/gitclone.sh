#!/bin/bash
# Git Clone

function private {
  username=$(cat /vagrant/GIT/username)
	password=$(cat /vagrant/GIT/password)
	repository=$(cat /vagrant/GIT/repository)
	git clone https://$username:$password@github.com/$username/$repository
}

function public {
	repository=$(cat /vagrant/GIT/repository)
	git clone https://github.com/$username/$repository
}

dir=/vagrant/GIT/repository

if [ -f "$dir" ]
then
  echo "Is it a private repository?"
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) private; break;;
          No ) public; break;;
      esac
  done
fi