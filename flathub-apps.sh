#!/bin/bash
set -e

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Firefox
flatpak install --noninteractive flathub org.mozilla.firefox
rm /usr/share/applications/firefox.desktop

# Blender
flatpak install --noninteractive flathub org.blender.Blender

# Gimp
flatpak install --noninteractive flathub org.gimp.GIMP

# Mpv
flatpak install --noninteractive flathub io.mpv.Mpv
