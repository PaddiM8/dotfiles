#!/bin/bash

set -e

echo Before running this, you need to create and log in to a \
    user account. Then, you must place an .ssh folder in the \
    user\'s home folder, containing ssh keys and a config.
read -p "Press any key to continue..."

progress=0

increment_progress() {
    ((++progress))
    echo $progress > .progress
}

if [ -f ".progress" ]; then
    progress=$(cat .progress)
fi

# Fetch system files
if (( $progress < 1 )); then
    sudo pacman --noconfirm -S rsync openssh git
    sudo -E rsync -avhR \
        -e "ssh -i $HOME/.ssh/id_rsa -F $HOME/.ssh/config" \
        server:/external/systems/pc/ \
        / \
        --no-relative

    increment_progress
fi

if (( $progress < 2 )); then
    # Set up time/date/locale
    sudo ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
    sudo hwclock --systohc
    sudo locale-gen

    increment_progress
fi

# Fetch non-shared user files
if (( $progress < 3 )); then
    rsync -avhR \
        server:/external/pc/ \
        ~/ \
        --no-relative

    increment_progress
fi

# Install yay
if (( $progress < 4 )); then
    mkdir -p ~/clones
    cd ~/clones
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm

    increment_progress
fi

# Install all packages
if (( $progress < 5 )); then
    yay -S --noconfirm --needed - < ~/packages.txt

    increment_progress
fi

# Enable services
if (( $progress < 6 )); then
    sudo systemctl enable ly
    sudo systemctl enable bluetooth
    sudo systemctl enable NetworkManager
    sudo systemctl enable acpi-wake
    sudo systemctl enable reflector.timer
    sudo systemctl enable ntpd
    sudo systemctl enable --now earlyoom
    systemctl --user enable ssh-agent
    systemctl --user enable pipewire
    systemctl --user enable pipewire-media-session
    systemctl --user enable pipewire-pulse
    systemctl --user enable unison

    increment_progress
fi

# XDG
if (( $progress < 7 )); then
    xdg-settings set default-web-browser firefoxdeveloperedition.desktop
    xdg-mime default firefoxdeveloperedition.desktop text/html
    xdg-mime default org.pwmt.zathura.desktop application/pdf
    xdg-mime default imv.desktop image/png
    xdg-mime default imv.desktop image/jpeg
    xdg-mime default imv.desktop image/*

    increment_progress
fi

# Misc
if (( $progress < 8 )); then
    sudo chsh -s /usr/bin/fish
    chsh -s /usr/bin/fish

    increment_progress
fi

mkdir -p ~/.local/share/gnupg
sudo chmod u+s `which fusermount`
git config --global rerere.enabled true

echo "fs.inotify.max_user_instances=32768" | sudo tee -a /etc/sysctl.conf

rm .progress
