#!/bin/bash
set -e

# Should've set hostname and dns already.

# hostnamectl set-hostname {hostname}
# IFACE=$(nmcli -f DEVICE,TYPE device | grep ethernet | head -n1 | awk '{print $1;}')
# nmcli conn modify $IFACE ipv4.dns  "{dns ip} 1.1.1.1 1.0.0.1"
# nmcli conn modify $IFACE ipv4.ignore-auto-dns yes

dnf install freeipa-client
ipa-client-install --enable-dns-update --mkhomedir
ipa-client-automount
