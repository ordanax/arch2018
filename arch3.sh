#!/bin/bash
mkdir ~/Downloads
cd ~/Downloads
echo 'Установка AUR (yay)'
sudo pacman -Syy
sudo pacman -S wget --noconfirm
wget git.io/yay-install.sh && sh yay-install.sh --noconfirm

echo 'Создаем нужные директории'
sudo pacman -S xdg-user-dirs --noconfirm
xdg-user-dirs-update

echo 'Установка программ'
sudo pacman -S firefox ufw qt4 f2fs-tools dosfstools ntfs-3g alsa-lib alsa-utils file-roller p7zip unrar gvfs aspell-ru pulseaudio --noconfirm
# obs-studio veracrypt freemind filezilla cherrytree gimp libreoffice libreoffice-fresh-ru kdenlive audacity screenfetch vlc qbittorrent gnome-calculator --noconfirm 
# yay -S dropbox flameshot-git obs-linuxbrowser xflux xflux-gui-git sublime-text2 hunspell-ru pamac-aur --noconfirm 

echo 'Установка тем'
yay -S osx-arc-shadow breeze-obsidian-cursor-theme papirus-maia-icon-theme-git --noconfirm

echo 'Ставим лого ArchLinux в меню'
wget git.io/arch_logo.png
sudo mv -f ~/Downloads/arch_logo.png /usr/share/pixmaps/arch_logo.png

echo 'Ставим обои на рабочий стол'
wget git.io/bg.jpg
sudo rm -rf /usr/share/backgrounds/xfce/* #Удаляем стандартрые обои
sudo mv -f ~/Downloads/bg.jpg /usr/share/backgrounds/xfce/bg.jpg

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Добавляем в автозагрузку:'
sudo systemctl enable ufw

sudo rm -rf ~/Downloads

echo 'Установка завершена!'
