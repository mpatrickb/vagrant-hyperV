#!/usr/bin/env bash

cd /vagrant/
php bin/console server:start
php bin/console cache:clear --env=dev
#php bin/console cache:clear --env=prod

#https://knpuniversity.com/screencast/symfony3/json-api#play