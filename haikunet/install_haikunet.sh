#Installation script for UBUNTU
RUBY_VERSION=$(ruby -v)
if [-n $RUBY_VERSION ]
    #installation and configuration of rvm
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash

    #installing ruby
    rvm install 2.3
    rvm use 2.3
fi

#installation and configuration steps for haikunet

