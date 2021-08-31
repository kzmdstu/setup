#!/bin/bash
set -e

HERE=$(dirname $BASH_SOURCE)

dnf -y update

echo "Installing Nvidia Driver"
#
# NOTE:
# 	Nvidia driver from official homepage makes me rebuild every time I update kernel. Use elrepo package.
#
dnf -y install https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
dnf -y install nvidia-detect
NVIDIA_DRIVER=$(nvidia-detect 2>&1 | head -n 1)
if [[ $NVIDIA_DRIVER == "kmod-nvidia" ]]; then
	dnf -y install kmod-nvidia
else
	echo "check output of nvidia-detect then install approprite version of nividia driver"
fi

echo "Installing Firefox"
#
# NOTE:
#	Flathub version of Firefox had problem with typing in Korean. Switched to native build.
#
if [[ ! -f "$HERE/firefox.tar.bz2" ]]; then
	wget -O "$HERE/firefox.tar.bz2" -nc "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"
fi
tar -C /opt -xf "$HERE/firefox.tar.bz2"


echo "Installing Blender"
#
# NOTE:
#	Flathub version of Blender didn't recognize graphic cards. Switched to native build.
#
if [[ ! -f "$HERE/blender.tar.xz" ]]; then
	wget -O "$HERE/blender.tar.xz" -nc https://download.blender.org/release/Blender2.93/blender-2.93.1-linux-x64.tar.xz
fi
mkdir -p /opt/blender
tar -C /opt/blender -xf "$HERE/blender.tar.xz"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "Installing GIMP"
flatpak install --noninteractive flathub org.gimp.GIMP
echo "Installing Mpv"
flatpak install --noninteractive flathub io.mpv.Mpv
