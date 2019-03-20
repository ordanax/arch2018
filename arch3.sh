#!/bin/bash
mkdir ~/Downloads
cd ~/Downloads


echo 'Качаем и устанавливаем настройки Xfce'
# Чтобы сделать копию ваших настоек XFCE перейдите в домашнюю директорию ~/username открйте в этой категории терминал и выполните команду ниже.
# tar -czf xfce4.tar.gz .config/xfce4
# Выгрузите архив в интернет и скорректируйте ссылку на XFCE файл заменив ссылку на свою.

rm -rf ~/.config/xfce4/*
wget git.io/xfce4.tar.gz
#tar -xzf xfce4.tar.gz -C ~/

echo 'Ставим лого ArchLinux в меню'
wget git.io/arch_logo.png
sudo mv -f ~/Downloads/arch_logo.png /usr/share/pixmaps/arch_logo.png

echo 'Ставим обои на рабочий стол'
wget git.io/bg.jpg
sudo rm -rf /usr/share/backgrounds/xfce/* #Удаляем стандартрые обои
sudo mv -f ~/Downloads/bg.jpg /usr/share/backgrounds/xfce/bg.jpg

sudo rm -rf ~/Downloads

echo 'Установка завершена!'
