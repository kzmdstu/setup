#!/bin/bash
set -e

# Base Image: Rocky Linux 8.5

# Please do update the distro, then reboot first.
# It would not work properly otherwise.
UNAME=$(uname -r)
# dnf -y update

HERE=$(dirname $BASH_SOURCE)

echo "Installing Nvidia Driver"
dnf -y install epel-release
dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo
# $(uname -r) trick will not work if `dnf update` has made jump on the latest kernel, but you are still using an old one.
# Please reboot, then.
dnf -y install kernel-devel-$(uname -r) kernel-headers-$(uname -r)
dnf -y install nvidia-driver nvidia-settings
dnf -y install cuda-driver

echo "Installing Blender"
if [[ ! -f "$HERE/blender.tar.xz" ]]; then
	wget -O "$HERE/blender.tar.xz" -nc https://download.blender.org/release/Blender2.93/blender-2.93.1-linux-x64.tar.xz
fi
mkdir -p /opt/blender
tar -C /opt/blender -xf "$HERE/blender.tar.xz"

echo "Installing Firefox Video Codecs"
dnf -y install rpmfusion-free-release
dnf -y install gstreamer1-libav

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "Installing GIMP"
flatpak install --noninteractive flathub org.gimp.GIMP
echo "Installing Mpv"
flatpak install --noninteractive flathub io.mpv.Mpv

echo "Done. Please reboot to take effect."
