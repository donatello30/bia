#!/bin/bash
# Todo lo que sigue es despues de haber hecho el pacman -S base bae-devel runit elogind-runit y el pacman -S linux-lts linux-firmware 
# Y el artix-chroot /mnt
# this is for  "LANG=en_US.UTF-8":   sed -i '177s/.//' /etc/locale.gen
ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock --systohc
sed -i '185s/.//' /etc/locale.gen
locale-gen
echo "LANG=es_CO.UTF-8" >> /etc/locale.conf
echo "KEYMAP=la-latin1" >> /etc/vconsole.conf
echo "hostname" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 hostname.localdomain hostname" >> /etc/hosts
echo root:123| chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm
 
pacman -S grub os-prober efibootmgr networkmanager networkmanager-runit network-manager-applet linux-headers dosfstools xdg-user-dirs xdg-utils intel-ucode

#pacman -S xf86_64-video-intel xorg --ignore xorg-server-xdmx sddm sddm-runit

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB 
#change the directory to /boot/efi is you mounted the EFI partition at /boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

#systemctl enable NetworkManager
#systemctl enable bluetooth
#systemctl enable cups.service
#systemctl enable sshd
#systemctl enable avahi-daemon
#systemctl enable tlp # You can comment this command out if you didn't install tlp, see #above
#systemctl enable reflector.timer
#systemctl enable fstrim.timer
#systemctl enable libvirtd
#systemctl enable firewalld
#systemctl enable acpid

# Create User
#useradd -m user
#echo user:123 | chpasswd
#usermod -aG wheel user
#echo "user ALL=(ALL) ALL" >> /etc/sudoers.d/user

printf "\e[1;32mLo lograste! crea el usuario y password despues Type exit, umount -R /mnt and reboot.\e[0m"




