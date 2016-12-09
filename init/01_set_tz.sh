#!/bin/bash

set -o nounset

timezone() { timezone="${1:-"UTC"}"
[[ -e /usr/share/zoneinfo/$timezone ]] || {
  echo "ERROR: invalid timezone specified: $timezone" >&2
  return
}

if [[ -w /etc/timezone && $(cat /etc/timezone) != $timezone ]]; then
  echo "$timezone" >/etc/timezone
  ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
  dpkg-reconfigure -f noninteractive tzdata >/dev/null 2>&1
fi
}

shift $(( OPTIND - 1 ))

[[ "${TZ:-""}" ]] && timezone "$TZ"
