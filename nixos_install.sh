#!/usr/bin/env bash

set -xe

echo "[*] Parititioning disk $disk_name"
disk_name="nvme0n1"
boot_part="/dev/${disk_name}p1"
root_part="/dev/${disk_name}p2"
parted "/dev/${disk_name}" -- mklabel gpt
parted "/dev/${disk_name}" -- mkpart ESP fat32 1MB 512MB
parted "/dev/${disk_name}" -- mkpart primary 512MB 100%
parted "/dev/${disk_name}" -- set 1 esp on

echo "[*] Creating LUKS encrypted container"
cryptsetup luksFormat "${root_part}"
cryptsetup open "${root_part}" cryptlvm

echo "[*] Preparing LVM logical volumes"
vol_grp_name="MyVolGroup"
pvcreate "/dev/mapper/cryptlvm"
vgcreate "${vol_grp_name}" "/dev/mapper/cryptlvm"
lvcreate -L 8G "${vol_grp_name}" -n swap
lvcreate -l "100%FREE" "${vol_grp_name}" -n root

echo "[*] Formatting LVM volumes"
mkfs.fat -F32 "${boot_part}" -n boot 
mkfs.ext4 "/dev/${vol_grp_name}/root"
mkswap "/dev/${vol_grp_name}/swap"

echo "[*] Mounting file systems"
mount "/dev/${vol_grp_name}/root" /mnt
mount /dev/disk/by-label/boot /mnt/boot
swapon "/dev/${vol_grp_name}/swap"

echo "[*] Generating minimal NixOS configuration"
nixos-generate-config --root /mnt

echo "[+] Install complete! Modify /mnt/etc/nixos/configuration.nix before rebooting"
