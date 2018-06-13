#!/bin/bash

# Установочный скрипт ALFI (от Arch Linux Full Install - Полная установка Arch Linux)
# Цель скрипта - быстрое развертывание системы с вашими персональными настройками (конфиг XFCE, темы, программы и т.д.).

# В разработке принимали участие:
# Алексей Бойко https://vk.com/ordanax
# Степан Скрябин https://vk.com/zurg3
# Михаил Сарвилин https://vk.com/michael170707
# Данил Антошкин https://vk.com/danil.antoshkin

loadkeys ru
setfont cyr-sun16
echo 'Скрипт сделан на основе чеклиста Бойко Алексея по Установке ArchLinux'
echo 'Ссылка на чек лист есть в группе vk.com/arch4u'

echo '2.3 Синхронизация системных часов'
timedatectl set-ntp true

echo '2.4 создание разделов'
(
  echo o;

  echo n;
  echo;
  echo;
  echo;
  echo +100M;
  echo y;

  echo n;
  echo;
  echo;
  echo;
  echo +20G;
  echo y;

  echo n;
  echo;
  echo;
  echo;
  echo +1024M;
  echo y;

  echo n;
  echo p;
  echo;
  echo;
  echo y;
  echo a;
  echo 1;

  echo w;
) | fdisk /dev/sda

echo 'Ваша разметка диска'
fdisk -l

echo '2.4.2 Форматирование дисков'
mkfs.ext2  /dev/sda1 -L boot
mkfs.ext4  /dev/sda2 -L root
mkswap /dev/sda3 -L swap
mkfs.ext4  /dev/sda4 -L home

echo '2.4.3 Монтирование дисков'
mount /dev/sda2 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
swapon /dev/sda3
mount /dev/sda4 /mnt/home

echo '3.1 Выбор зеркал для загрузки. Используем программу Reflector'
pacman -Sy --noconfirm reflector
pacman -S --noconfirm --needed reflector
reflector -l 3 --sort rate --save /etc/pacman.d/mirrorlist

echo '3.2 Установка основных пакетов'
pacstrap /mnt base base-devel

echo '3.3 Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

echo 'Переходим в установлнную систему.'
echo '1) Установите wget, командой: pacman -S wget'
echo '2) Скачайте вторую часть скрипта командой: wget ordanax.ru/arch/arch_2.sh'
echo '3) Запустите скрипт командой: sh arch_2.sh'
arch-chroot /mnt
