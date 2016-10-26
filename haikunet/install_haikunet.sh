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
    	yes | apt-get install curl
    fi

    RVM_SCRIPT=$(\curl -sSL https://get.rvm.io)
    eval RVM_SCRIPT
    source /etc/profile.d/rvm.sh

    #installing ruby
    rvm install 2.3
    rvm use 2.3
fi

#Installation and configuration steps for haikunet

#First we create the binary in order to be run from console
HAIKUNET_DIRECTORY=$(pwd)
if [[ $EUID -ne 0 ]]; then
	sudo ln -s "$HAIKUNET_DIRECTORY/lib/haikunet.rb" /usr/bin/haikunet
else
	ln -s "$HAIKUNET_DIRECTORY/lib/haikunet.rb" /usr/bin/haikunet
fi

#Second, we install bundler if not installed
BUNDLER_INSTALLED=$(gem query -i -n bundler)
if [[ !BUNDLER_INSTALLED ]]; then
	gem install bundler
fi

#Finally, we install all gems
bundler install