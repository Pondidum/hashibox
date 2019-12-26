#!/bin/ash -eu

apk add docker

rc-update add docker boot
rc-service docker start

adduser "vagrant" "docker"
