set -e

dnf groupinstall -y workstation
systemctl set-default graphical.target
systemctl isolate graphical
