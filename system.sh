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

echo "Installing Useful Drivers/Programs"
dnf -y install filezilla
dnf -y install ntfs-3g
dnf -y install exfat-utils fuse-exfat
dnf -y install libreoffice-writer libreoffice-calc libreoffice-impress

echo "Installing USBGuard"
dnf -y install usbguard
install -m 0600 -o root -g root $HERE/data/rules.conf /etc/usbguard/rules.conf
systemctl enable --now usbguard

echo "System Configuration"
echo "X-GNOME-Autostart-enabled=false" >> /etc/xdg/autostart/gnome-initial-setup-first-login.desktop
echo "y" | cp $HERE/data/mimeapps.list /etc/xdg/mimeapps.list
dnf -y install ffmpegthumbnailer
echo "y" | cp /usr/share/thumbnailers/ffmpegthumbnailer.thumbnailer /usr/share/thumbnailers/totem.thumbnailer
cp $HERE/data/application-x-nuke.xml /usr/share/mime/packages/
update-mime-database /usr/share/mime
update-desktop-database /usr/local/share/applications

echo "Setting up IPA Client"
# TODO: find non-interactive way to install; maybe using --random password generated
dnf -y install freeipa-client
ipa-client-install --enable-dns-update --mkhomedir
ipa-client-automount --unattended
# override kerberos renew setting
echo "y" | cp $HERE/data/krb5.conf /etc/krb5.conf
echo "  $(hostname) = IN.KZMDSTU.COM" >> /etc/krb5.conf

# prepare cifs mount to install program as root
mkdir -p /root/drnss
echo "y" | cp $HERE/data/mount-installer.sh /root/

echo "Done. Please reboot and install Nvidia driver"
