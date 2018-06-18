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
makepkg -si --noconfirm
cd ..
rm -rf aurman

echo 'Установка программ'
sudo pacman -S dmenu scrot feh firefox ufw pidgin ntfs-3g screenfetch alsa-lib alsa-utils p7zip unrar pulseaudio --noconfirm
# obs-studio veracrypt freemind filezilla cherrytree gimp libreoffice libreoffice-fresh-ru kdenlive audacity screenfetch vlc qt4 qbittorrent f2fs-tools dosfstools ntfs-3g gnome-calculator file-roller gvfs aspell-ru pulseaudio --noconfirm 
aurman -S dropbox joxi obs-linuxbrowser purple-vk-plugin purple-facebook pidgin-encryption sublime-text2 hunspell-ru pamac-aur --noconfirm 

echo 'Установка тем'
aurman -S compton lxappearance terminus-ttf xkblayout-state ttf-font-awesome --noconfirm

echo 'Создаем нужные директории.'
mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Music/
mkdir ~/Video/
mkdir ~/Dropbox/
mkdir ~/Dropbox/WALLPAPERS
mkdir ~/Dropbox/WALLPAPERS/GREEN/

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Установка завершена!'
rm -rf ~/arch_3.sh
