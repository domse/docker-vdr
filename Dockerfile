# -----------------------------------------------------------------------------
# docker-vdr
#
# Builds a basic docker image that can run a vdr server
# (http://www.tvdr.de/).
#
# Authors: Dominik Bücker
# Updated: 16.09.2014
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------

# Base system is the precise LTS version of Ubuntu.
from  ubuntu:12.04

# don't ask for stupid things
env   DEBIAN_FRONTEND noninteractive

#update the system
run		apt-get -y update && apt-get -y upgrade
#install dependencies
run	  apt-get -y install python-software-properties


# adding yavdr specific stuff
run   apt-add-repository -y ppa:yavdr/main
run   apt-add-repository -y ppa:yavdr/stable-vdr
run   apt-add-repository -y ppa:yavdr/stable-yavdr
run   apt-add-repository -y ppa:yavdr/stable-xbmc

#update the system
run		apt-get -y update && apt-get -y upgrade

# install vdr stuff
#run   apt-get -y install vdr vdr-streamdev-server vdr-plugin-vnsiserver vdr-plugin-xvdr vdr-plugin-live
run apt-get -y install dvb-driver-sundtek-mediaclient 
run apt-get -y install yavdr-utils yavdr-base yavdr-essential

# add config files

add    ./supervisor/supervisord.conf /etc/supervisor/supervisord.conf
add    ./supervisor/conf.d/vdr.conf /etc/supervisor/conf.d/vdr.conf
add    ./supervisor/conf.d/tntnet.conf /etc/supervisor/tntnet.d/vdr.conf
add    ./scripts/start /start

# modify permissions
run chmod +x /start


# Start supervisor-init-System
# here we need to make sure that the whole yavdr stuff is reflected
cmd    ["/start"]
