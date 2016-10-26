#!/bin/bash

#Installation script for UBUNTU
RUBY_VERSION=$(which ruby)
if [ -z "${RUBY_VERSION// }" ]
 then
    #installation and configuration of rvm
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

    CURL_VERSION=$(which curl)

    if [ -z "${CURL_VERSION// }"]
    	then
    	apt-get install curl
    fi

    \curl -sSL https://get.rvm.io | bash
    source /etc/profile.d/rvm.sh

    #installing ruby
    rvm install 2.3
    rvm use 2.3
fi

#installation and configuration steps for haikunet
HAIKUNET_DIRECTORY=$(pwd)
if [[ $EUID -ne 0 ]]; then
	sudo ln -s "$HAIKUNET_DIRECTORY/lib/haikunet.rb" /usr/bin/haikunet
else
	ln -s "$HAIKUNET_DIRECTORY/lib/haikunet.rb" /usr/bin/haikunet
fi