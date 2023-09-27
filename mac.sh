#!/bin/bash

echo "set name of this computer (without domain)"
echo -n "name: "
read name

fqdn="${name}.in.kzmdstu.com"

scutil --set HostName "${fqdn}"

scp root@idm01:/etc/ipa/ca.crt /etc/ipa/

ssh admin@idm01 ipa host-add --force "${fqdn}"
ssh admin@idm01 ipa ipa-getkeytab -p host/"${fqdn}" -k "${name}.keytab"
scp admin@idm01:"${name}.keytab" /etc/krb5.keytab

cp $HERE/data/mac_krb5.conf /etc/krb5.conf
IFS="." read -r host domain <<< "${fqdn}"

echo "nfs.client.mount.options = vers=4.0,sec=krb5i" > /etc/nfs.conf

echo "next step:"
echo "  1. add keychain /etc/ipa/ca.crt to system"
echo "  2. run 'kinit {user}' to access nas"
