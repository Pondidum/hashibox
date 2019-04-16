#! /bin/bash

set -e

box_name=hashibox.box

rm -f $box_name

vagrant up

vagrant package --output $box_name
vagrant box add --force --name pondidum/hashibox $box_name

vagrant destroy -f
