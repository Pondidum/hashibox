#! /bin/bash

NOMAD_VERSION=0.9.5
CONSUL_VERSION=1.6.0
VAULT_VERSION=1.2.2

OUTPUT_DIR="./binaries"

mkdir -p $OUTPUT_DIR

pushd $OUTPUT_DIR

echo "fetching Nomad..."
curl -sSL https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip -o nomad.zip

echo "fetching Consul..."
curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip

echo "fetching Vault..."
curl -sSL https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -o vault.zip

echo "fetching containerd..."
curl -sSL https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/containerd.io_1.2.4-1_amd64.deb -O

echo "fetching docker-cli..."
curl -sSL https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce-cli_18.09.3~3-0~ubuntu-xenial_amd64.deb -O

echo "fetching docker-cd..."
curl -sSL https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce_18.09.3~3-0~ubuntu-xenial_amd64.deb -O

for bin in cfssl cfssl-certinfo cfssljson
do
    echo "fetching ${bin}..."
    curl -sSL https://pkg.cfssl.org/R1.2/${bin}_linux-amd64 > ${bin}
done

echo "fetching dotnet core..."
curl -sSL https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb -O

popd
