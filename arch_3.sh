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
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo 'Установка программ'
sudo pacman -S most neofetch lxappearance vim rtorrent mplayer nodejs ntfs-3g dmenu feh alsa-lib alsa-utils chromium p7zip unrar pulseaudio --noconfirm
yay -S sublime-text-dev arc-gtk-theme polybar ls_extended ttf-roboto-mono openvpn cmus evince openssh sxiv yarn virtualbox imlib2-webp-git --noconfirm
#sudo pacman -S scrot pidgin screenfetch --noconfirm
#okular obs-studio veracrypt freemind filezilla cherrytree gimp libreoffice libreoffice-fresh-ru kdenlive audacity screenfetch qt4 f2fs-tools dosfstools gnome-calculator file-roller gvfs aspell-ru --noconfirm 
#aurman -S dropbox obs-linuxbrowser purple-vk-plugin purple-facebook pidgin-encryption hunspell-ru --noconfirm 

echo 'Создаем нужные директории.'
mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Video/
mkdir -p ~/Storages/usb_{a,b}

echo 'Включаем сетевой экран'
#sudo ufw enable


# sudo systemctl enable dropbox@p347
shopt -s extglob
echo 'Установка завершена!'
rm -rf ~/arch_3.sh
