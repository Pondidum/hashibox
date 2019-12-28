#!/bin/sh -eu

DISK_USAGE_BEFORE_CLEANUP=$(df -h)

echo "==> Cleanup"
echo "    Deleting Artefacts"

find /var/cache -type f -exec rm -rf {} \;
find /var/log/ -name "*.log" -exec rm -f {} \;
find /tmp/ -type f -exec rm -f {} \;

echo "==> whiteout /root"
count=$(df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}')
count=$(($count-1))
dd if=/dev/zero of=/tmp/whitespace bs=1M count=$count || echo "dd exit code $? is suppressed";
rm /tmp/whitespace

echo  "    whiteout /boot"
count=$(df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}')
count=$(($count-1))
dd if=/dev/zero of=/boot/whitespace bs=1M count=$count || echo "dd exit code $? is suppressed";
rm /boot/whitespace

sync;

echo "    Disk usage before cleanup"
echo "$DISK_USAGE_BEFORE_CLEANUP"

echo "    Disk usage after cleanup"
df -h

echo "    Done"
