#!/bin/bash

fails=0

machine_ip=$(ip addr show eth0 | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}')
docker_ip=$(ip addr show docker0 | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}')

echo "==> Verifying Machine"
echo "    eth0 IP:    $machine_ip"
echo "    docker0 IP: $docker_ip"

echo "==> Pre-pulling containers"

docker pull alpine &>/dev/null

echo "==> Running checks"


host_dig=$(dig "$HOSTNAME" +short)

if [ "$host_dig" == "$machine_ip" ]; then
  state="success"
else
  state="fail"
  (( fails ++ ))
fi
echo "    $state: \$HOSTNAME resolves to host IP"

# `vagrant ssh -c ...` returns a string ending in \r\n for some reason
# even when both host and child boxes are linux...


container_nameserver=$(docker run --rm -it alpine /bin/sh -c 'cat /etc/resolv.conf' | grep "nameserver $docker_ip" | tr -d '\r')
if [ "$container_nameserver" == "nameserver $docker_ip" ]; then
  state="success"
else
  state="fail"
  (( fails ++ ))
fi
echo "    $state: Container has nameserver set to machine's docker IP"


container_dig=$(docker run --rm -it alpine /bin/sh -c "apk add bind-tools --quiet --no-progress && dig +short $HOSTNAME" | tr -d '\r')
if [ "$container_dig" == "$machine_ip" ]; then
  state="success"
else
  state="fail"
  (( fails ++ ))
fi
echo "    $state: Container can resolve host's name to host IP"

echo "==> Complete"
echo "    Failures: $fails"

if [ "$fails" -gt 0 ]; then
  exit 1
fi
