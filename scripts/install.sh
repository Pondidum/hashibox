#!/bin/ash -eu

apk update
apk add \
  git \
  musl-dev \
  zip \
  libcap \
  bind-tools \
  tmux \
  jq

install /vagrant/binaries/yq /usr/local/bin
chmod +x /usr/local/bin/yq
