#!/bin/bash
set -e

echo "Updating The Distro"
dnf -y update

echo "Installing Nvidia Driver"
dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo
# The $(uname -r) trick might not work if `dnf update` has made jump on the latest kernel,
# but you are still using an old one.
# Please reboot and run this script again, then.
dnf -y install kernel-devel-$(uname -r) kernel-headers-$(uname -r)
dnf -y install nvidia-driver:latest-dkms # or :latest, or install kmod-nvidia-{version}... instead

echo "Done. Please reboot to take effect."

