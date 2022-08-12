#!/bin/bash
if [ ! -f /config/msmtprc ]; then
cp /tmp/msmtprc /config/msmtprc
fi
cp /config/msmtprc /etc/msmtprc
