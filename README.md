# magicdude4eva/smokeping
[![](https://images.microbadger.com/badges/image/magicdude4eva/smokeping.svg)](https://microbadger.com/images/magicdude4eva/smokeping "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/magicdude4eva/smokeping.svg)](https://microbadger.com/images/magicdude4eva/smokeping "Get your own version badge on microbadger.com")

Smokeping keeps track of your network latency. For a full example of what this application is capable of visit [UCDavis](http://smokeping.ucdavis.edu/cgi-bin/smokeping.fcgi). The Smokeping Docker image includes the latest version of Smokeping, speedtest-cli and PhantomJS.


[![smokeping](http://oss.oetiker.ch/smokeping/inc/smokeping-logo.png)][smokeurl]
[smokeurl]: http://oss.oetiker.ch/smokeping/

## Usage

```
docker create \
    --name smokeping \
    -p 9500:80 \
    -e PUID=<UID> -e PGID=<GID> \
    -e TZ=<timezone> \
    -v <path/to/smokeping/data>:/data \
    -v <path/to/smokeping/config>:/config \
    magicdude4eva/smokeping
```


## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 9500:80 would expose port 80 from inside the container to be accessible from the host's IP on port 9500
http://192.168.x.x:9500 would show you what's running INSIDE the container on port 80.`


* `-p 80` - the port for the webUI
* `-v /data` - Storage location for db and application data (graphs etc)
* `-v /config` - Configure the `Targets` file here
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation
* `-e TZ` for timezone setting, eg Africa/Johannesburg

This container is based on phusion/baseimage and includes the latest build of PhantomJS. For shell access whilst the container is running do `docker exec -it smokeping /bin/bash`.

### User / Group Identifiers
Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" <sup>TM</sup>.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id dockeruser
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

Once running the URL will be `http://<host-ip>:9500/smokeping/smokeping.cgi`.

Basics are, edit the Targets file to ping the hosts you're interested in to match the format found there. 
Wait 10 minutes.

## Info

* To monitor the logs of the container in realtime `docker logs -f smokeping`.


**Version**

+ **09.12.16:** First release.
