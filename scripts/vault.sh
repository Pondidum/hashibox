#!/bin/ash -eu

binaries=/vagrant/binaries
src=/vagrant/vault

addgroup -S vault 2>/dev/null
adduser -S -D -h /var/vault -s /sbin/nologin -G vault -g vault vault 2>/dev/null

mkdir -p /etc/vault

cp $src/vault.hcl /etc/vault/vault.hcl
cp $src/vault.initd /etc/vault/vault.initd
cp $src/vault.confd /etc/conf.d/vault

chown -R vault:vault /etc/vault

unzip $binaries/vault.zip -d /tmp
install /tmp/vault /usr/local/bin

setcap cap_ipc_lock=+ep /usr/local/bin/vault
