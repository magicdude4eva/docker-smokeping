#!/bin/bash

if [ ! -f /config/Alerts ]; then
  cp /tmp/Alerts /config/Alerts
fi

if [ ! -f /config/Database ]; then
  cp /tmp/Database /config/Database
fi

if [ ! -f /config/General ]; then
  cp /tmp/General /config/General
fi

if [ ! -f /config/Presentation ]; then
  cp /tmp/Presentation /config/Presentation
fi

if [ ! -f /config/Probes ]; then
  cp /tmp/Probes /config/Probes
fi

if [ ! -f /config/Slaves ]; then
  cp /tmp/Slaves /config/Slaves
fi

if [ ! -f /config/Targets ]; then
  cp /tmp/Targets /config/Targets
fi

if [ ! -f /config/pathnames ]; then
  cp /tmp/pathnames /config/pathnames
fi
