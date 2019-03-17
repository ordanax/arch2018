#!/bin/bash
echo 'Установка AUR (yay)'
sudo pacman -Syy
sudo pacman -S wget --noconfirm
wget git.io/yay-install.sh && sh yay-install.sh
sudo rm -rf ~/yay-install.sh

echo 'Установка программ'
sudo pacman -S firefox ufw --noconfirm
# obs-studio veracrypt freemind filezilla cherrytree gimp libreoffice libreoffice-fresh-ru kdenlive audacity screenfetch vlc qt4 qbittorrent f2fs-tools dosfstools ntfs-3g alsa-lib alsa-utils gnome-calculator file-roller p7zip unrar gvfs aspell-ru pulseaudio --noconfirm 
# yay -S dropbox flameshot-git obs-linuxbrowser xflux xflux-gui-git sublime-text2 hunspell-ru pamac-aur --noconfirm 

echo 'Установка тем'
yay -S osx-arc-shadow breeze-obsidian-cursor-theme papirus-maia-icon-theme-git --noconfirm

echo 'Установка завершена!'
rm -rf ~/arch3.sh
