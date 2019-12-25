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

* enable consul: `sudo ln -s /etc/consul/consul.initd /etc/init.d/consul`
* enable vault: `sudo ln -s /etc/vault/vault.initd /etc/init.d/vault`