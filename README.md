docker-vdr
==========

Basic headless VDR Server based on Docker and yavdr

THIS IS NOT READY TO USE AND UNUSABLE!
======================================

To play build the image, run it, log into it with docker-bash or nsenter. CHange the order.conf according to our needs and start vdr manually (service vdr start).

Keep in mind to minimally export 8008 (live) and 3000 (streamdev).

My commands:

1. docker build --rm=true -t "jondalar/docker-yavdr-headless" .

2. docker run -d --privileged --name="yavdr" -p 80:80 -p 34890:34890 -p 3000:3000 -p 10022:22 -p 8008:8008 -p 34890:34890 jondalar/docker-yavdr-headless

3. docker-bash yavdr


