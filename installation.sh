#!/bin/bash

#set -e

###############################################################################

# Author	:	Tamas Gabor

###############################################################################

# UPDATE THE SYSTEM CLOCK
timedatectl set-ntp true

# Format the partition
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

# Mount the filesystem
mount /dev/sda2 /mnt
touch /mnt/swapfile

dd if=/dev/zero of=/mnt/swapfile bs=1M count=4096
chmod 600 /mnt/swapfile
mkswap /mnt/swapfile
swapon /mnt/swapfile
swapfile="yes"

# Select the mirrors
pacman -S --needed --noconfirm reflector
reflector --verbose -l 20 -p https --sort rate --save /etc/pacman.d/mirrorlist
