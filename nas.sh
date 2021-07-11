#!/bin/bash
set -e

mkdir /mnt/drnss
echo "username=" >> /etc/.drnss_credentials
echo "password=" >> /etc/.drnss_credentials
chmod 600 /etc/.drnss_credentials
echo "//nas.kzmdstu.com/drnss /mnt/drnss cifs defaults,uid=1000,gid=1000,credentials=/etc/.drnss_credentials" >> /etc/fstab
echo "please add credentials to /etc/.drnss_credentials to mount drnss, then mount it with 'mount -a'"
