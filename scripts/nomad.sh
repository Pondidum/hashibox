#!/bin/bash -eu

echo "==> Installing Nomad"

echo "https://sjc.edge.kernel.org/alpine/edge/testing" | tee -a /etc/apk/repositories
echo "https://sjc.edge.kernel.org/alpine/edge/community" | tee -a /etc/apk/repositories
apk update
apk add nomad ip6tables

echo "    building configuration directories"
rm -rf /etc/nomad.d
rm /etc/init.d/nomad
mv /usr/sbin/nomad /usr/local/bin/nomad
chmod +xr /usr/local/bin/nomad

binaries=/vagrant/binaries
src=/vagrant/nomad

echo "    adding default configuration"
mkdir -p /etc/nomad

cp $src/nomad.hcl /etc/nomad/nomad.hcl
cp $src/nomad.initd /etc/init.d/nomad
cp $src/nomad.confd /etc/conf.d/nomad

echo  "    installing CNI plugins"

mkdir -p /opt/cni/bin
tar -C /opt/cni/bin -xzf $binaries/cni-plugins.tgz

echo 1 > /proc/sys/net/bridge/bridge-nf-call-arptables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables

echo "==> Done"
