#!/bin/bash
# Git Clone

dir=/GIT/gitpassword

if [ -f "$dir" ]
then 
    username=$(cat /vagrant/username)
	password=$(cat /vagrant/password)
	repository=$(cat /vagrant/repository)
	git clone https://$username:$password@github.com/$username/$repository
fi