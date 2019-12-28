#!/bin/ash -eu

apk add icu-libs

dotnet_sdk_version=3.1.100
dotnet_url="https://dotnetcli.azureedge.net/dotnet/Sdk/$dotnet_sdk_version/dotnet-sdk-$dotnet_sdk_version-linux-musl-x64.tar.gz"
dotnet_sha512='517c1dadbc9081e112f75589eb7160ef70183eb3d93fd55800e145b21f4dd6f5fbe19397ee7476aa16493e112ef95b311ff61bb08d9231b30a7ea609806d85ee'

curl -sSL "$dotnet_url" -o /tmp/dotnet.tar.gz
echo "$dotnet_sha512  /tmp/dotnet.tar.gz" | sha512sum -c -

mkdir -p /usr/share/dotnet
tar -C /usr/share/dotnet -oxzf /tmp/dotnet.tar.gz
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
rm /tmp/dotnet.tar.gz

dotnet help


apk add go
echo "GO111MODULE=on" >> "$HOME/.profile"
