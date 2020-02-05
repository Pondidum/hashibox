#!/bin/sh -eu

src=/vagrant/docker

echo "==> Configuring Docker"

apk add docker
cp $src/docker.confd /etc/conf.d/docker

echo "    Starting docker"
rc-service docker start
rc-update add docker boot

echo "    Adding vagrant user to docker group"
adduser "vagrant" "docker"

echo "    Done"
