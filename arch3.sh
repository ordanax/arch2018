#!/bin/bash
rm -rf ~/.config/xfce4/*
mkdir ~/downloads
cd ~/downloads

echo 'Установка AUR (yay)'
sudo pacman -Syu
sudo pacman -S wget --noconfirm
wget git.io/yay-install.sh && sh yay-install.sh --noconfirm

echo 'Создаем нужные директории'
sudo pacman -S xdg-user-dirs --noconfirm
xdg-user-dirs-update

echo 'Установка базовых программ и пакетов'
sudo pacman -S firefox firefox-i18n-ru ufw f2fs-tools dosfstools ntfs-3g alsa-lib alsa-utils file-roller p7zip unrar gvfs aspell-ru pulseaudio pavucontrol --noconfirm

echo 'Установить рекомендумые программы?'
read -p "1 - Да, 0 - Нет: " prog_set
if [[ $prog_set == 1 ]]; then
  #Можно заменить на pacman -Qqm > ~/.pacmanlist.txt
  sudo pacman -S recoll obs-studio veracrypt vlc freemind filezilla gimp libreoffice libreoffice-fresh-ru kdenlive screenfetch vlc qbittorrent galculator gnome-disk-utility telegram-desktop opera --noconfirm
  wget https://git.io/Jvr57 --noconfirm
  yay -S --noconfirm - < .aurlist.txt
  sudo rm -rf ~/downloads/.aurlist.txt
  sudo rm -rf ~/.config/xfce4/*
elif [[ $prog_set == 0 ]]; then
  echo 'Установка программ пропущена.'
fi

echo 'Скачать и установить конфиг и темы для XFCE?'
read -p "1 - Да, 0 - Нет: " xfce_set
if [[ $xfce_set == 1 ]]; then
  echo 'Качаем и устанавливаем настройки Xfce'
  # Чтобы сделать копию ваших настоек перейдите в домашнюю директорию ~/username открйте в этой категории терминал и выполните команду ниже.
  # tar -czf config.tar.gz .config
  # Выгрузите архив в интернет и скорректируйте ссылку на свою.
  wget https://github.com/ordanax/arch/blob/master/attach/config.tar.gz
  sudo rm -rf ~/.config/xfce4/panel/
  sudo rm -rf ~/.config/xfce4/*
  sudo tar -xzf config.tar.gz -C ~/
  echo 'Удаление тем по умолчанию'
  sudo rm -rf /usr/share/themes/*
  echo 'Установка тем'
  yay -S papirus-maia-icon-theme-git breeze-default-cursor-theme --noconfirm
  sudo pacman -S capitaine-cursors
  echo 'Установка темы OSX-Arc-Shadow'
  wget https://github.com/thiagolucio/OSX-Arc-Shadow/archive/master.zip
  cd ~/downloads
  unzip OSX-Arc-Shadow-master.zip
  sudo mv -f ~/downloads/OSX-Arc-Shadow-master /usr/share/themes
  
  echo 'Ставим лого ArchLinux в меню'
  wget git.io/arch_logo.png
  sudo mv -f ~/downloads/arch_logo.png /usr/share/pixmaps/arch_logo.png

  echo 'Ставим обои на рабочий стол'
  wget git.io/bg.jpg
  sudo rm -rf /usr/share/backgrounds/xfce/* #Удаляем стандартрые обои
  sudo mv -f ~/downloads/bg.jpg /usr/share/backgrounds/xfce/bg.jpg
elif [[ $xfce_set == 0 ]]; then
  echo 'Установка конфигов XFCE пропущена.'
fi 

echo "Ставим i3 с моими настройками?"
read -p "1 - Да, 2 - Нет" vm_setting
if [[ $vm_setting == 1 ]]; then
    pacman -S i3-wm i3-gaps i3status sbxkb dmenu pcmanfm ttf-font-awesome feh lxappearance thunar gvfs udiskie xorg-xbacklight ristretto tumbler compton --noconfirm
    yay -S polybar
    wget https://github.com/ordanax/dots/raw/master/i3wm_v_2/i3wm_config.tar.gz
    sudo rm -rf ~/.config/i3/*
    sudo rm -rf ~/.config/polybar/*
    sudo tar -xzf i3wm_config.tar.gz -C ~/
elif [[ $vm_setting == 2 ]]; then
  echo 'Пропускаем.'
fi

echo 'Убираем меню граб для выбора системы?'
read -p "1 - Да, 0 - Нет: " grub_set
if [[ $grub_set == 1 ]]; then
  wget git.io/grub.tar.gz
  sudo tar -xzf grub.tar.gz -C /
  sudo grub-mkconfig -o /boot/grub/grub.cfg
elif [[ $grub_set == 0 ]]; then
  echo 'Пропускаем.'
fi

#echo 'Убираем DE?'
read -p "1 - Да, 0 - Нет: " node_set
if [[ $node_set == 1 ]]; then
sudo pacman -S xorg-xinit
cp /etc/X11/xinit/xserverrc ~/.xserverrc
cd ~/
wget https://raw.githubusercontent.com/ordanax/arch/master/attach/.xinitrc
sudo rm -rf ~/.bashrc
wget https://raw.githubusercontent.com/ordanax/arch/master/attach/.bashrc
su -c 'read -p "Введите ваш логин: " nodelogin && echo "[Service]" > /etc/systemd/system/getty@tty1.service.d/override.conf && echo "ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/override.conf && echo "ExecStart=-/usr/bin/agetty --autologin $nodelogin --noclear %I $TERM" >> /etc/systemd/system/getty@tty1.service.d/override.conf'
sudo systemctl disable lxdm
sudo pacman -R lxdm

elif [[ $node_set == 0 ]]; then
  echo 'Пропускаем.'
fi

echo 'Установить conky?'
read -p "1 - Да, 0 - Нет: " conky_set
if [[ $conky_set == 1 ]]; then
  sudo pacman -S conky conky-manager --noconfirm
  wget git.io/conky.tar.gz
  tar -xzf conky.tar.gz -C ~/
elif [[ $conky_set == 0 ]]; then
  echo 'Установка conky пропущена.'
fi

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Добавляем в автозагрузку:'
sudo systemctl enable ufw

sudo rm -rf ~/downloads
sudo rm -rf ~/archuefi3.sh

echo 'Установка завершена!'
