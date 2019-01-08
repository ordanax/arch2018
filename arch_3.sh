#!/bin/bash
echo 'Установка AUR (aurman)'
sudo pacman -Syy
sudo pacman -S git --noconfirm

#Ставим зависимость expac-git
git clone https://aur.archlinux.org/expac-git.git
cd expac-git
makepkg -si --noconfirm
cd ..
rm -rf expac-git

#Ставим aurman
git clone https://aur.archlinux.org/aurman.git
cd aurman
sudo pacman -S archlinux-keyring
sudo pacman-key -r 465022E743D71E39
gpg --recv-keys 465022E743D71E39
makepkg -si --noconfirm
cd ..
rm -rf aurman

echo 'Установка программ'
sudo pacman -S most lxappearance vim rtorrent mplayer ufw nodejs ntfs-3g dmenu feh alsa-lib alsa-utils chromium p7zip unrar pulseaudio --noconfirm
aurman -S sublime-text-dev dropbox arc-gtk-theme openvpn cmus evince openssh sxiv yarn virtualbox imlib2-webp-git 
--noconfirm
#sudo pacman -S scrot pidgin screenfetch --noconfirm
#okular obs-studio veracrypt freemind filezilla cherrytree gimp libreoffice libreoffice-fresh-ru kdenlive audacity screenfetch qt4 f2fs-tools dosfstools gnome-calculator file-roller gvfs aspell-ru --noconfirm 
#aurman -S obs-linuxbrowser purple-vk-plugin purple-facebook pidgin-encryption hunspell-ru --noconfirm 

echo 'Установка тем'
sudo pacman -S neofetch --noconfirm
aurman -S compton polybar ls_extended ttf-roboto-mono --noconfirm

echo 'Создаем нужные директории.'
mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Video/
mkdir -p ~/Storages/usb_{a,b}

echo 'Включаем сетевой экран'
#sudo ufw enable


sudo systemctl enable dropbox@p347
shopt -s extglob
echo 'Установка завершена!'
rm -rf ~/arch_3.sh
