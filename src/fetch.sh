#! /bin/bash

CONSUL_VERSION=1.6.2
VAULT_VERSION=1.3.1

OUTPUT_DIR="./src/binaries"

mkdir -p $OUTPUT_DIR

pushd $OUTPUT_DIR

echo "fetching Consul..."
curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip

echo "fetching Vault..."
curl -sSL https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -o vault.zip

for bin in cfssl cfssl-certinfo cfssljson
do
    echo "fetching ${bin}..."
    curl -sSL https://pkg.cfssl.org/R1.2/${bin}_linux-amd64 > ${bin}
done

popd
