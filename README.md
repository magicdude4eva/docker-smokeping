# magicdude4eva/smokeping
[![](https://images.microbadger.com/badges/image/magicdude4eva/smokeping.svg)](https://microbadger.com/images/magicdude4eva/smokeping "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/magicdude4eva/smokeping.svg)](https://microbadger.com/images/magicdude4eva/smokeping "Get your own version badge on microbadger.com")

[paypal]: https://paypal.me/GerdNaschenweng
![paypal](https://img.shields.io/badge/PayPal--ffffff.svg?style=social&logo=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8%2F9hAAAABHNCSVQICAgIfAhkiAAAAZZJREFUOI3Fkb1PFFEUxX%2F3zcAMswFCw0KQr1BZSKUQYijMFibGkhj9D4zYYAuU0NtZSIiNzRZGamqD%2BhdoJR%2FGhBCTHZ11Pt%2B1GIiEnY0hFNzkFu%2FmnHPPPQ%2Buu%2BTiYGjy0ZPa5N1t0SI5m6mITeP4%2B%2FGP%2Fbccvto8j3cuCsQTSy%2FCzLkdxqkXpoUXJoUXJrkfFTLMwHiDYLrFz897Z3jT6ckdBwsiYDMo0tNOIGuBqS%2Beh7sdAkU2g%2BkBFGkd%2FrtSgD8Z%2BrBxj68MAGG1A9efRhVsXrKMU7Y4cNyGOwtDU28OtrqdUMetldvzFKxCYSHJ4NsJ%2BnRJGexHba7VJ%2FTff4BaQFBjVcbqIEZ1bESYn4PRUcHx2N952awUkOHZedUcWm14%2FtjqjREHawUEsgx6Ajg5%2Bsi7jWqBwA%2BmIrXlo9YHUVTmEP%2F6hOO1Ofiyy3pjo%2BsvBDX%2FZpSakhz4BqvQDvdYvrXQEXZViI5rPpBEOwR2l16vtN7bd9SN3L1WXj%2BjGSnN38rq%2B7VL8xXQOdDF%2F0KvXn8BlbuY%2FvUAHysAAAAASUVORK5CYII%3D)
___
:beer: **Please support me**: Although all my software is free, it is always appreciated if you can support my efforts on Github with a [contribution via Paypal][paypal] - this allows me to write cool projects like this in my personal time and hopefully help you or your business. 
___

Smokeping keeps track of your network latency. For a full example of what this application is capable of visit [UCDavis](http://smokeping.ucdavis.edu/cgi-bin/smokeping.fcgi). The Smokeping Docker image includes the latest version of Smokeping, speedtest-cli and PhantomJS.

![Smokeping Docker](https://github.com/magicdude4eva/docker-smokeping/raw/master/docker-smokeping.png)

## TL;DR - Features
* Latest version of Smokeping (https://github.com/oetiker/SmokePing)
* Speedtest probe (https://github.com/mad-ady/smokeping-speedtest / https://github.com/sivel/speedtest-cli)
* PhantomJS (http://phantomjs.org/)
* Working configuration for DNS, Speedtest and web-site probes

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


## Donations are always welcome

[paypal]: https://paypal.me/GerdNaschenweng

🍻 **Support my work**  
All my software is free and built in my personal time. If it helps you or your business, please consider a small donation via [PayPal][paypal] — it keeps the coffee ☕ and ideas flowing!

💸 **Crypto Donations**  
You can also send crypto to one of the addresses below:

```
(CRO)   0xb83c3Fe378F5224fAdD7a0f8a7dD33a6C96C422C (Cronos)  
(USDC)  0xb83c3Fe378F5224fAdD7a0f8a7dD33a6C96C422C (ERC20)  
(ETH)   0xfc316ba7d8dc325250f1adfafafc320ad75d87c0  
(BNB)   0xfc316ba7d8dc325250f1adfafafc320ad75d87c0
(BTC)   bc1q24fuw84l6whm20umlr56nvqjn908sec8pavk3z  
Crypto.com PayString: magicdude$paystring.crypto.com
```

🧾 **Recommended Platforms**  
- 👉 [Curve.com](https://www.curve.com/join#DWPXKG6E): Add your Crypto.com card to Apple Pay  
- 🔐 [Crypto.com](https://crypto.com/app/ref6ayzqvp): Stake and get your free Crypto Visa card  
- 📈 [Binance](https://accounts.binance.com/register?ref=13896895): Trade altcoins easily