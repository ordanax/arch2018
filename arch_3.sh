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
sudo pacman -S nodejs vim openvpn --noconfirm
sudo pacman -S dmenu scrot feh firefox ufw pidgin ntfs-3g screenfetch alsa-lib alsa-utils p7zip unrar pulseaudio --noconfirm
# obs-studio pamac-aur veracrypt freemind filezilla cherrytree gimp libreoffice libreoffice-fresh-ru kdenlive audacity screenfetch vlc qt4 qbittorrent f2fs-tools dosfstools ntfs-3g gnome-calculator file-roller gvfs aspell-ru --noconfirm 
aurman -S dropbox joxi obs-linuxbrowser purple-vk-plugin purple-facebook pidgin-encryption sublime-text2 hunspell-ru --noconfirm 

echo 'Установка тем'
aurman -S compton lxappearance terminus-ttf xkblayout-state ttf-font-awesome --noconfirm

echo 'Создаем нужные директории.'
mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Music/
mkdir ~/Video/
mkdir ~/Dropbox/

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Установка завершена!'
rm -rf ~/arch_3.sh
