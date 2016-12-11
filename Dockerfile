FROM phusion/baseimage:0.9.18
MAINTAINER MagicDude4Eva, https://github.com/magicdude4eva/docker-smokeping

# ========================================================================================
# ====== PhantomJS
# Dependencies we just need for building phantomjs
ENV buildDependencies \
    bison \
    build-essential \
    flex \
    g++ \
    git \
    gperf \
    libpng-dev \
    libsqlite3-dev \
    libssl-dev \
    perl \
    ruby \
    unzip \
    wget 

# Dependencies we need for running phantomjs
ENV phantomJSDependencies \
    libfontconfig1-dev \
    libfreetype6 \
    libicu-dev \
    libjpeg-dev \
    openssl \
    python
  
ENV phantomVersion 2.1.1

# Compiling and installing PhantomJS
RUN \
    # Installing dependencies
    apt-get update -yqq \
&&  apt-get install -fyqq ${buildDependencies} ${phantomJSDependencies}\
    # Downloading src, unzipping & removing zip
&&  mkdir phantomjs \
&&  cd phantomjs \
&&  git clone https://github.com/ariya/phantomjs.git . \
&&  git checkout ${phantomVersion} \
&&  ./build.py --confirm --release --git-clean-qtbase --git-clean-qtwebkit \
&&  cp bin/phantomjs /usr/bin/phantomjs \
    # Removing build dependencies, clean temporary files
&&  apt-get purge -yqq ${buildDependencies} \
&&  apt-get autoremove -yqq \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /phantomjs \
    # Checking if phantom works
&&  phantomjs -v

# ========================================================================================


# ========================================================================================
# ====== SmokePing
# Apache environment settings
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" TERM="xterm" APACHE_LOG_DIR="/var/log/apache2" APACHE_LOCK_DIR="/var/lock/apache2" APACHE_PID_FILE="/var/run/apache2.pid"

# Applying stuff
RUN \
    apt-get update \
&&  apt-get install -y apache2 fping smokeping ssmtp syslog-ng ttf-dejavu unzip \
&&  rm /etc/ssmtp/ssmtp.conf \
&&  ln -s /etc/smokeping/apache2.conf /etc/apache2/conf-available/apache2.conf \
&&  a2enconf apache2 \
&&  a2enmod cgid \
&&  apt-get autoremove -y \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
ADD Alerts /tmp/Alerts
ADD Database /tmp/Database
ADD General /tmp/General
ADD Presentation /tmp/Presentation
ADD Probes /tmp/Probes
ADD Slaves /tmp/Slaves
ADD Targets /tmp/Targets
ADD pathnames /tmp/pathnames
ADD ssmtp.conf /tmp/ssmtp.conf
ADD config /etc/smokeping/config
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh
RUN mkdir /var/run/smokeping

# Update Smokeping
RUN \
    curl -L -o /tmp/smokeping.zip https://github.com/oetiker/SmokePing/archive/master.zip \
&&  cd /tmp \
&&  unzip -o smokeping.zip \
&&  cp /tmp/SmokePing-master/bin/smokeping_cgi /usr/share/smokeping/smokeping.cgi \
&&  cp -Rv /tmp/SmokePing-master/htdocs/cropper/ /usr/share/smokeping/www/cropper \
&&  cp /tmp/SmokePing-master/htdocs/cropper/cropper.js /usr/share/smokeping/www/cropper/cropper.min.js \
&&  cp /tmp/SmokePing-master/bin/smokeping /usr/sbin \
&&  cp /tmp/SmokePing-master/bin/smokeinfo /usr/sbin \
&&  cp /tmp/SmokePing-master/lib/*.pm /usr/share/perl5/ \
&&  cp -Rv /tmp/SmokePing-master/lib/Smokeping/* /usr/share/perl5/Smokeping \
&&  chown -R www-data: /var/cache/smokeping/ \
&&  ln -s /var/cache/smokeping/ /usr/share/smokeping/www/cache

# Add custom probes
# Download and copy Speedtest - https://github.com/mad-ady/smokeping-speedtest
RUN \
    curl -L -o /usr/share/perl5/Smokeping/probes/speedtest.pm https://github.com/mad-ady/smokeping-speedtest/raw/master/speedtest.pm

# Download and copy speedtest-cli - https://github.com/sivel/speedtest-cli
RUN \
    curl -L -o /usr/local/bin/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py \
&&  chmod a+x /usr/local/bin/speedtest-cli


# ========================================================================================
# Adjust syslog-ng / cleanup
RUN \
    # Update repository and install syslog-ng
    apt-get update \
&&  apt-get install -y syslog-ng \
    # Adjusting SyslogNG - see https://github.com/phusion/baseimage-docker/pull/223/commits/dda46884ed2b1b0f7667b9cc61a961e24e910784
&&  sed -ie "s/^       system();$/#      system(); #This is to avoid calls to \/proc\/kmsg inside docker/g" /etc/syslog-ng/syslog-ng.conf \
&&  apt-get autoremove -y \
&&  apt-get clean 


# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Volumes and Ports
VOLUME /config
VOLUME /data
EXPOSE 80
# ========================================================================================
