#!/bin/ash -eu

binaries=/vagrant/binaries
src=/vagrant/consul

addgroup -S consul 2>/dev/null
adduser -S -D -h /var/consul -s /sbin/nologin -G consul -g consul consul 2>/dev/null

mkdir -p /etc/consul

cp $src/consul.json /etc/consul/consul.json
cp $src/consul.initd /etc/consul/consul.initd
cp $src/consul.confd /etc/conf.d/consul

chown -R consul:consul /etc/consul

unzip $binaries/consul.zip -d /tmp
install /tmp/consul /usr/local/bin