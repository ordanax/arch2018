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

  echo n;
  echo;
  echo;
  echo;
  echo +20G;

  echo n;
  echo;
  echo;
  echo;
  echo +1024M;

  echo n;
  echo p;
  echo;
  echo;
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

echo '3.1 Выбор зеркал для загрузки. Ставим Российские зеркала'
echo "#Russia
Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch
Server = https://mirror.yandex.ru/archlinux/\$repo/os/\$arch
Server = http://mirror.truenetwork.ru/archlinux/\$repo/os/\$arch
Server = http://mirror.rol.ru/archlinux/\$repo/os/\$arch
Server = https://mirror.rol.ru/archlinux/\$repo/os/\$arch
Server = http://mirror.aur.rocks/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

#По желанию другие зеркала:
#echo 'Украинcкие зеркала'
#echo "#Ukraine
#Server = http://mirrors.nix.org.ua/linux/archlinux/\$repo/os/\$arch
#Server = http://archlinux.ip-connect.vn.ua/\$repo/os/\$arch
#Server = https://archlinux.ip-connect.vn.ua/\$repo/os/\$arch
#Server = https://mirrors.nix.org.ua/linux/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

#echo 'Белорусские зеркала'
#echo '#Belarus
#Server = http://mirror.datacenter.by/pub/archlinux/\$repo/os/\$arch
#Server = http://ftp.byfly.by/pub/archlinux/\$repo/os/\$arch' > /etc/pacman.d/mirrorlist

echo '3.2 Установка основных пакетов'
pacstrap /mnt base base-devel

echo '3.3 Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

arch-chroot /mnt sh -c "$(curl -fsSL ordanax.ru/arch/arch_2.sh)"
