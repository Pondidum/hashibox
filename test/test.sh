#!/bin/bash -e

vagrant up

if vagrant ssh -c "/vagrant/verify.sh"; then
  echo "Tests Passed"
else
  echo "Tests Failed"
fi

vagrant destroy -f
