#!/bin/bash

cd ~
rsync -avhR --delete \
    packages.txt \
    backups/ \
    documents/ \
    misc/ \
    pictures/ \
    projects/ \
    uni/ \
    .vimrc \
    .vim/ \
    .config/ideavim \
    .config/user-dirs.dirs \
    .config/i3 \
    .config/kalker \
    .config/JetBrains/*/options \
    .config/JetBrains/*/jba_config \
    .config/sway \
    .config/dunst \
    .config/kitty \
    .config/alacritty \
    .config/fish \
    .config/rofi \
    .config/picom \
    .config/neofetch \
    .config/ly \
    .config/espanso \
    .config/Code\ -\ OSS/User \
    .scripts \
    .ssh/id_rsa \
    .ssh/id_rsa.pub \
    .ssh/config \
    .local/bin/tools \
    paddi@bakk.strct.net:/pc \
    --exclude="node_modules/" \
    --exclude="bin/" \
    --exclude="obj/" \
    --exclude="target/" \
    --exclude="build/" \
    --exclude="dist/" \
    --exclude="workspaceStorage/" \
    --exclude='globalStorage/' \
    --exclude="resharper-host/"
