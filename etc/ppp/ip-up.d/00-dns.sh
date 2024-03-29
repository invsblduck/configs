#!/bin/sh

# brc
# Don't mess with our resolver, man.
exit 0

if [ "$USEPEERDNS" = "1" -a -f /etc/ppp/resolv.conf ]; then
  if [ -x /usr/bin/resolvconf ]; then
    /usr/bin/resolvconf -a ${IFNAME} </etc/ppp/resolv.conf
  else
    [ -e /etc/resolv.conf ] && mv /etc/resolv.conf /etc/resolv.conf.backup.${IFNAME}
    mv /etc/ppp/resolv.conf /etc/resolv.conf
    chmod 644 /etc/resolv.conf
  fi
fi
