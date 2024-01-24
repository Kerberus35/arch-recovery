cryptsetup open /dev/nvme0n1p2 luks
mount -o noatime,nodiratime,compress=lzo,space_cache=v2,ssd,subvol=@ /dev/mapper/luks /mnt
mkdir -p /mnt/{boot,home,var/cache/pacman/pkg,var/log,.snapshots,btrfs}
mount -o noatime,nodiratime,compress=lzo,space_cache=v2,ssd,subvol=@home /dev/mapper/luks /mnt/home
mount -o noatime,nodiratime,compress=lzo,space_cache=v2,ssd,subvol=@pkg /dev/mapper/luks /mnt/var/cache/pacman/pkg
mount -o noatime,nodiratime,compress=lzo,space_cache=v2,ssd,subvol=@var_log /dev/mapper/luks /mnt/var/log
mount -o noatime,nodiratime,compress=lzo,space_cache=v2,ssd,subvol=@snapshots /dev/mapper/luks /mnt/.snapshots
mount -o noatime,nodiratime,compress=lzo,space_cache=v2,ssd,subvolid=5 /dev/mapper/luks /mnt/btrfs
mount /dev/nvme0n1p1 /mnt/boot
apt install arch-install-scripts
arch-chroot /mnt/
pacman -Syyu linux linux-headers
mkinitcpio -P
