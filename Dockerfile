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

# Base system is the precise LTS version of Ubuntu with init System.
from  phusion/baseimage:12.04

# don't ask for stupid things
env   DEBIAN_FRONTEND noninteractive
env   HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#install dependencies
run	  apt-get --yes install python-software-properties

run   apt-add-repository ppa:yavdr/stable-vdr

#update the system
run		apt-get --yes update; apt-get --yes upgrade

run   apt-get -y install vdr vdr-streamdev-server vdr-plugin-vnsiserver vdr-plugin-xvdr vdr-plugin-live

# 80 is for nginx web, /data contains static files and database /start runs it.
# expose 25565 have to have a look what is wanted
# volume ["/data"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
