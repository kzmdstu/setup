set -e

wget -N https://us.download.nvidia.com/XFree86/Linux-x86_64/460.84/NVIDIA-Linux-x86_64-460.84.run
dnf groupinstall -y "Development Tools"
dnf install -y libglvnd-devel elfutils-libelf-devel
grub2-editenv - set "$(grub2-editenv - list | grep kernelopts) nouveau.modeset=0"
reboot
/mnt/drnss/library/driver/nvidia/NVIDIA-Linux-x86_64-460.84.run
