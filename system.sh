#!/bin/bash
set -e

# Base Image: Rocky Linux 8.5

HERE=$(dirname $BASH_SOURCE)

echo "Updating The Distro"
dnf -y update

echo "Installing Nvidia Driver"
dnf -y install epel-release
dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo
# The $(uname -r) trick might not work if `dnf update` has made jump on the latest kernel,
# but you are still using an old one.
# Please reboot and run this script again, then.
dnf -y install kernel-devel-$(uname -r) kernel-headers-$(uname -r)
dnf -y install nvidia-driver nvidia-settings
dnf -y install cuda-driver

echo "Installing Firefox Video Codecs"
dnf -y install rpmfusion-free-release
dnf -y install gstreamer1-libav

echo "Installing Mpv"
dnf config-manager --set-enabled powertools
dnf -y install mpv

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "Installing GIMP"
flatpak install --noninteractive flathub org.gimp.GIMP

echo "Setting up IPA Client"
# TODO: find non-interactive way to install; maybe using --random password generated
dnf -y install freeipa-client
ipa-client-install --enable-dns-update --mkhomedir
ipa-client-automount --unattended

echo "Done. Please reboot to take effect."
