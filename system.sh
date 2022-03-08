#!/bin/bash
set -e

# Base Image: Rocky Linux 8.5

HERE=$(dirname $BASH_SOURCE)

echo "Updating The Distro"
dnf -y update
dnf -y install epel-release
dnf config-manager --set-enabled powertools
dnf -y install rpmfusion-free-release

echo "Installing FFmpeg"
dnf -y install ffmpeg

echo "Installing Mpv"
dnf -y install mpv
printf "keep-open\nloop-playlist=inf" > /etc/mpv/mpv.conf

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "Installing GIMP"
flatpak install --noninteractive flathub org.gimp.GIMP

echo "Setting up IPA Client"
# TODO: find non-interactive way to install; maybe using --random password generated
dnf -y install freeipa-client
ipa-client-install --enable-dns-update --mkhomedir
ipa-client-automount --unattended
# override kerberos renew setting
cp $HERE/data/krb5.conf /etc/krb5.conf
echo "  $(hostname) = IN.KZMDSTU.COM" >> /etc/krb5.conf

echo "Etc..."
echo "X-GNOME-Autostart-enabled=false" >> /etc/xdg/autostart/gnome-initial-setup-first-login.desktop

echo "Done. Please reboot and install Nvidia driver"
