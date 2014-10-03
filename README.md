docker-vdr
==========

Basic headless VDR Server based on Docker and yavdr

THIS IS ALPHA SOFTWARE (or maybe pre) AND MIGHT BE UNUSABLE!
======================================

To play build the image, run it, log into it with docker-bash or nsenter. Fill the /etc/vdr/conf.d folder with the plugins you need from conf.aval. 

Feel free to test but don't expect full functionality.

Keep in mind to minimally export 8008 (live) and 3000 (streamdev).

My commands:

1. docker build --rm=true -t "jondalar/docker-yavdr-headless" .

2. docker run -d --privileged --name="yavdr" -p 80:80 -p 10022:22 -p 8008:8008 -p 34890:34890 jondalar/docker-yavdr-headless

3. docker-bash yavdr


