#!/bin/ash -eu

echo "https://sjc.edge.kernel.org/alpine/edge/testing" | tee -a /etc/apk/repositories
apk update
apk add nomad

rm -rf /etc/nomad.d
rm /etc/init.d/nomad
mv /usr/sbin/nomad /usr/local/bin/nomad
chmod +xr /usr/local/bin/nomad

src=/vagrant/nomad

mkdir -p /etc/nomad

cp $src/nomad.hcl /etc/nomad/nomad.hcl
cp $src/nomad.initd /etc/nomad/nomad.initd
cp $src/nomad.confd /etc/conf.d/nomad
