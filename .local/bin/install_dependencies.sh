#!/bin/bash

sudo dnf update

# install core tools
sudo dnf install -y vim tree wget curl tree

# add workstation repository
sudo dnf install -y fedora-workstation-repositories

# install google chrome
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install -y google-chrome-stable

# install zsh
sudo dnf install -y zsh
chsh -s $(which zsh)
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

