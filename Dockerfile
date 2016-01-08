# -----------------------------------------------------------------------------
# docker-yavdr-headless
#
#
# Based on: Dominik Bücker
# Updated: 16.09.2014
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------

#FROM ubuntu:14.04.3
FROM ubuntu-upstart:latest
MAINTAINER jondalar <alex@iphonedation.com>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# don't ask for stupid things
env   DEBIAN_FRONTEND noninteractive
RUN echo APT::Install-Recommends "0"; >> /etc/apt/apt.conf 
RUN echo APT::Install-Suggests "0"; >> /etc/apt/apt.conf 

#update the system
RUN apt-get -y update && apt-get -y upgrade && dpkg-divert --local --rename --add /sbin/initctl && \
    ln -sf /bin/true /sbin/initctl

# adding yavdr specific stuff
run   apt-get -y install aptitude add-apt-key software-properties-common python-software-properties
run   add-apt-repository -y ppa:yavdr/main
run   add-apt-repository -y ppa:yavdr/stable-vdr
run   add-apt-repository -y ppa:yavdr/stable-yavdr
run   add-apt-repository -y ppa:yavdr/stable-xbmc

# add mutiverse to sources.list to accomodate markad stuff
RUN echo "deb http://security.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list

#update the system
RUN apt-get -y update && apt-get -y upgrade


# install vdr stuff
RUN apt-get -y --no-install-recommends install yavdr-base vdr-plugin-iptv

#Expose Ports
EXPOSE 22 
EXPOSE 80 
EXPOSE 111 
EXPOSE 2004 
EXPOSE 2049 
EXPOSE 3000 
EXPOSE 6419 
EXPOSE 8002 
EXPOSE 8008

#add configfiles
#ADD ./vdrconfig/conf.d/ /etc/vdr/conf.d/
#ADD ./vdrconfig/conf.aval/ /etc/vdr/conf.aval/

#make a default user with name dockervdr and Password vdr
RUN adduser --disabled-password --gecos "" dockervdr
RUN echo "dockervdr:vdr"| chpasswd

# set a cheap, simple password for great convenience
RUN echo 'root:docker.io' | chpasswd

# we can has SSH
EXPOSE 22

# prepare for takeoff
CMD ["/sbin/init"]
