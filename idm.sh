#!/bin/bash
set -e

# Should've set hostname and dns already.

# hostnamectl set-hostname {hostname}
# nmcli conn modify {network-interface} ipv4.dns  "{dns ip} 1.1.1.1 1.0.0.1"
# nmcli conn modify {network-interface} ipv4.ignore-auto-dns yes

dnf install freeipa-client
ipa-client-install --enable-dns-update --mkhomedir
ipa-client-automount
