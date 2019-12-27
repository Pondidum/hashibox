#!/bin/ash -eu

binaries=/vagrant/binaries
src=/vagrant/consul

addgroup -S consul 2>/dev/null
adduser -S -D -h /var/consul -s /sbin/nologin -G consul -g consul consul 2>/dev/null

mkdir -p /etc/consul

cp $src/consul.json /etc/consul/consul.json
cp $src/consul.initd /etc/init.d/consul
cp $src/consul.confd /etc/conf.d/consul

chown -R consul:consul /etc/consul

unzip $binaries/consul.zip -d /tmp
install /tmp/consul /usr/local/bin

apk add unbound
cp $src/unbound.conf /etc/unbound/unbound.conf
rc-update add unbound

apk add dhclient
cp $src/dhclient.conf /etc/dhcp/dhclient.conf
cp $src/dhclient-enter-hooks /etc/dhclient-enter-hooks
cp $src/dhclient-exit-hooks /etc/dhclient-exit-hooks
rm /etc/resolv.conf
rc-service networking restart

while [ "$(rc-service unbound status)" != " * status: started" ]; do
  sleep 1
done
echo "==> unbound started"

while [ "$(rc-service openntpd status)" != " * status: started" ]; do
  sleep 1
done
echo "==> openntpd started"
