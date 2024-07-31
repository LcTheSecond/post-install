#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _    
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__ 
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__| 
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo
echo "POST SETUP START...."

# ------------------------------------------------------------------------

echo "Adding Chaotic AUR"
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

sudo echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
sudo pacman -Syu
echo "Sucess"


echo
echo "INSTALLING FIRMWARE"
echo

PKGS=(
      'linux-firmware-qlogic'
      'linux-firmware-bnx2x'
      'linux-firmware-liquidio'
      'linux-firmware-mellanox'
      'linux-firmware-nfp'
      'aic94xx-firmware'
      'ast-firmware'
      'wd719x-firmware'
      'upd72020x-fw'
      'b43-firmware'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done
echo "Sucess"

echo
echo "INSTALLING GNOME PACKAGES"
echo

PKGS=(
      'baobab'
      'gdm'
      'gnome-backgrounds'
      'gnome-control-center'
      'gnome-disk-utility'
      'gnome-font-viewer'
      'gnome-keyring'
      'gnome-menus'
      'gnome-session'
      'gnome-settings-daemon'
      'gnome-shell'
      'gnome-shell-extensions'
      'gnome-text-editor'
      'gnome-tweaks'
      'tecla'
      'xdg-desktop-portal-gnome'
      'xdg-user-dirs-gtk'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done
echo "Enable, GDM service"
sudo systemctl enable gdm
echo "Sucess"


echo
echo "INSTALLING Adicional"
echo

PKGS=(
      'git'
      'alacritty'
      'fish'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done
echo "Sucess"

git clone http://aur.archlinux.org/yay.git
cd /yay
makepkg -si
yay -Syu


echo
echo "INSTALLING from AUR (YAY)"
echo
PKGS=(
      'librewolf-bin'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    yay -S "$PKG"
done
echo "Sucess"

echo
echo "Done!"
echo
