#!/bin/sh

set -eu

box_name=hashibox.box
local_name="local/hashibox"

export VAGRANT_LIBVIRT_VIRT_SYSPREP_OPERATIONS="defaults,-ssh-userdir,-ssh-hostkeys"

vagrant up

sudo rm -f "$box_name"
sudo vagrant package --output "$box_name" --vagrantfile meta.rb
sudo chown "$USER:$USER" "$box_name"

vagrant box add --force --name "$local_name" "$box_name"
vagrant destroy -f
