#!/bin/bash -eu

CONSUL_VERSION=1.6.2
VAULT_VERSION=1.3.1
YQ_VERSION=2.4.1
CNI_VERSION=0.8.5

OUTPUT_DIR="./src/binaries"

mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

echo "==> Fetching binaries to $OUTPUT_DIR"

echo "    Consul $CONSUL_VERSION..."
curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip

echo "    Vault $VAULT_VERSION"
curl -sSL https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -o vault.zip

echo "    yq $YQ_VERSION"
curl -sSL https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 -o yq

echo "    CNI Plugins $CNI_VERSION"
curl -sSL https://github.com/containernetworking/plugins/releases/download/v${CNI_VERSION}/cni-plugins-linux-amd64-v${CNI_VERSION}.tgz -o cni-plugins.tgz


for bin in cfssl cfssl-certinfo cfssljson; do
  echo "    ${bin}"
  curl -sSL https://pkg.cfssl.org/R1.2/${bin}_linux-amd64 > ${bin}
done

echo "==> Done"
