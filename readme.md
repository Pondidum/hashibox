# Hashibox

A [Vagrant](https://www.vagrantup.com) base box for all my Hashicorp stack demos.  Also has dotnet core installed.

## Building

```bash
# caches most binaries used to build the box
# only need to run once really
./fetch.sh

# builds and adds the box locally
./build.sh
```

## Usage

Consul, Vault and Nomad can be started with `rc-service`: `sudo rc-service <name> start`
The can also be set to auto start on boot: `sudo rc-update add <name>`
