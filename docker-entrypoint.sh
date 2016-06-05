#!/bin/sh

set -e

if [ "$1" = 'pgpool' ]; then

  if [ ! -s "/etc/pgpool.conf" ]; then
      cp /etc/pgpool.conf.sample /etc/pgpool.conf
      cp /etc/pcp.conf.sample /etc/pcp.conf
      cp /etc/pool_hba.conf.sample /etc/pool_hba.conf
      if [ ! -s "/etc/pool_passwd.sample" ]; then
        touch /etc/pool_passwd.sample
      fi
      cp /etc/pool_passwd.sample /etc/pool_passwd
      touch /var/log/pgpool/pgpool_status
      chown postgres /etc/pool_passwd \
                     /etc/pcp.conf \
                     /etc/pool_hba.conf \
                     /etc/pgpool.conf \
                     /var/log/pgpool/pgpool_status
  fi

  sed -i "s:socket_dir = '.*':socket_dir = '/var/run/pgpool':g" /etc/pgpool.conf
  sed -i "s:pcp_socket_dir = '.*':pcp_socket_dir = '/var/run/pgpool':g" /etc/pgpool.conf
  IP_ADDR=$(ip addr show eth0 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
  sed -i "s:listen_addresses = '.*':listen_addresses = '$IP_ADDR':g" /etc/pgpool.conf

  gosu postgres "$@"
  
fi

exec "$@"