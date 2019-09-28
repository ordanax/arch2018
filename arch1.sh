#!/bin/bash

# Arch Linux Fast Install - Быстрая установка Arch Linux https://github.com/ordanax/arch2018
# Цель скрипта - быстрое развертывание системы с вашими персональными настройками (конфиг XFCE, темы, программы и т.д.).

# В разработке принимали участие:
# Алексей Бойко https://vk.com/ordanax
# Степан Скрябин https://vk.com/zurg3
# Михаил Сарвилин https://vk.com/michael170707
# Данил Антошкин https://vk.com/danil.antoshkin
# Юрий Порунцов https://vk.com/poruncov

loadkeys ru
setfont cyr-sun16
echo 'Скрипт сделан на основе чеклиста Бойко Алексея по Установке ArchLinux'
echo 'Ссылка на чек лист есть в группе vk.com/arch4u'

echo '2.3 Синхронизация системных часов'
timedatectl set-ntp true

echo "Что ставим Legacy/UEFI?"
echo "Legacy =0 UEFI=1 (в разработке)"
while 
    read -n1 -p  "
    0 - Legacy
    
    1 - UEFI: " vm_setting 
    echo ''
    [[ "$vm_setting" =~ [^10] ]] #только 1 или 0, ^0-9  цифры от 0 до 9
do
    :
done
if [[ $vm_setting  == 0 ]]; then
grub="grub"
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

elif [[ $vm_setting  == 1 ]]; then
grub="grub efibootmgr"

echo '2.4 создание разделов'
(
  echo g;

  echo n;
  echo 1;
  echo;
  echo +500M;
  echo t;
  echo 1;
  echo 1;

echo n;
  echo 2;
  echo;
  echo +20G;
  sleep 10
  
  echo n;
  echo 3;
  echo;
  echo;
  sleep 10
  
  echo w;
) | fdisk /dev/sda

echo 'Ваша разметка диска'
fdisk -l
sleep 10

echo '2.4.2 Форматирование дисков'
mkfs.fat -F32 /dev/sda1 
mkfs.ext4  /dev/sda2
mkfs.ext4  /dev/sda3

echo '2.4.3 Монтирование дисков'
mount /dev/sda2 /mnt
mkdir /mnt/home
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
mount /dev/sda3 /mnt/home

fi

echo '3.1 Выбор зеркал для загрузки. Ставим зеркало от Яндекс'
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

echo '3.2 Установка основных пакетов'
pacstrap /mnt base base-devel

echo '3.3 Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

arch-chroot /mnt sh -c "$(curl -fsSL git.io/arch2.sh)"
