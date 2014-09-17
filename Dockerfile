# -----------------------------------------------------------------------------
# docker-yavdr-headless
#
#
# Based on: Dominik Bücker
# Updated: 16.09.2014
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------

FROM phusion/baseimage:0.9.13
MAINTAINER jondalar <alex@iphonedation.com>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# don't ask for stupid things
env   DEBIAN_FRONTEND noninteractive

#update the system
run		apt-get -y update && apt-get -y upgrade
#install dependencies
#run	  apt-get -y install python-software-properties


# adding yavdr specific stuff
run   apt-add-repository -y ppa:yavdr/unstable-main
run   apt-add-repository -y ppa:yavdr/unstable-vdr
run   apt-add-repository -y ppa:yavdr/unstable-yavdr
run   apt-add-repository -y ppa:yavdr/unstable-xbmc

# add mutiverse to sources.list to accomodate markad stuff
RUN echo "deb http://security.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list

#update the system
RUN apt-get -y update && apt-get -y upgrade


# install vdr stuff
RUN apt-get -y install acpid anacron at avahi-daemon bash-completion build-essential cpufrequtils consolekit dvb-driver-sundtek-mediaclient ethtool ssh eventlircd hsetroot i965-va-driver ir-keytable irserver libpam-ck-connector linux-firmware linux-firmware-nonfree linux-firmware-yavdr lirc logrotate mhddfs nvram-wakeup pm-utils ubuntu-extras-keyring udisks-glue update-manager-core ureadahead usbutils vdr vdr-addon-acpiwakeup vdr-addon-avahi-linker vdr-addon-lifeguard vdr-plugin-avahi4vdr vdr-plugin-channellists vdr-plugin-dbus2vdr vdr-plugin-dummydevice vdr-plugin-dvbsddevice vdr-plugin-dvbhddevice vdr-plugin-dynamite vdr-plugin-epgsearch vdr-plugin-femon vdr-plugin-iptv vdr-plugin-live vdr-plugin-markad vdr-plugin-menuorg vdr-plugin-pvr350 vdr-plugin-restfulapi vdr-plugin-skinnopacity vdr-plugin-streamdev-server vdr-plugin-wirbelscan vdr-skins-speciallogos vdr-tftng-anthraize vdr-tftng-pearlhd vdr-tftng-standard vdr-xpmlogos vim wakeonlan wget wpasupplicant w-scan xfsprogs yavdr-base yavdr-hostwakeup yavdr-remote yavdr-utils yavdr-webfrontend


# Use baseimage-docker's init system
CMD ["/sbin/my_init"]
