#!/bin/bash

sudo dnf update

# Core tools
sudo dnf install -y vim tree wget curl tree unzip xprop xev

# Workstation repository
sudo dnf install -y fedora-workstation-repositories

# NumLock
sudo dnf install -y numlockx
gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true

# Audio
sudo dnf install -y playerctl

# Google Chrome
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install -y google-chrome-stable

# Vim plugins
git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox
git clone https://github.com/lilydjwg/colorizer ~/.vim/pack/default/start/colorizer

# ZSH
sudo dnf install -y zsh
chsh -s $(which zsh)
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Docker & Co
sudo dnf remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce \
		docker-ce-cli \
		containerd.io \
		docker-compose \
		docker-compose-plugin

newgrp docker
sudo usermod -aG docker $USER

sudo systemctl start docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# ASDF
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.0

asdf plugin-add java
asdf install java openjdk-17
asdf global java openjdk-17

asdf plugin-add jq     
asdf install jq 1.6
asdf global jq 1.6

asdf plugin-add maven
asdf install maven 3.8.6
asdf global maven 3.8.6

asdf plugin-add rust
asdf install rust 1.66.0
asdf global rust 1.66.0

asdf plugin-add httpie-go
asdf install httpie-go 0.7.0
asdf global httpie-go 0.7.0

asdf plugin-add golang
asdf install golang 1.19
asdf global golang 1.19

asdf plugin add lazydocker https://github.com/comdotlinux/asdf-lazydocker.git
asdf install lazydocker 0.20.0
asdf global lazydocker 0.20.0

# Alacritty
sudo dnf install -y alacritty

# SSH Server
sudo dnf install -y openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd

# Fonts
curl https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip -L -o /tmp/JetBrainsMono.zip
[[ -d "${HOME}/.local/share/fonts/JetBrainsMono" ]] || mkdir -p "${HOME}/.local/share/fonts/JetBrainsMono"
unzip /tmp/JetBrainsMono.zip -d "${HOME}/.local/share/fonts/JetBrainsMono"

curl https://github.com/FortAwesome/Font-Awesome/archive/refs/tags/6.2.1.zip -L -o /tmp/FontAwesome.zip
[[ -d "${HOME}/.local/share/fonts/FontAwesome" ]] || mkdir -p "${HOME}/.local/share/fonts/FontAwesome"
unzip /tmp/FontAwesome.zip -d "${HOME}/.local/share/fonts/FontAwesome"

curl https://github.com/supermarin/YosemiteSanFranciscoFont/archive/master.zip -L -o /tmp/YosemiteSanFranciscoFont.zip
[[ -d "${HOME}/.local/share/fonts/YosemiteSanFranciscoFont" ]] || mkdir -p "${HOME}/.local/share/fonts/YosemiteSanFranciscoFont"
unzip /tmp/YosemiteSanFranciscoFont.zip -d "${HOME}/.local/share/fonts/YosemiteSanFranciscoFont"

fc-cache -v

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
bash ~/.fzf/install

# GTK Theme
sudo dnf install -y lxappearance arc-theme numix-icon-theme-circle

# System monitor
sudo dnf copr enable atim/bottom -y
sudo dnf install -y bottom

# Screenshot
sudo dnf install -y flameshot

# Virtualization
sudo dnf install VirtualBox virtualbox-guest-additions.x86_64
curl https://dl.genymotion.com/releases/genymotion-3.3.2/genymotion-3.3.2-linux_x64.bin -L -o /tmp/genymotion.bin
chmod +x /tmp/genymotion.bin
mkdir /opt/genymotion
/tmp/genymotion.bin -d /opt/genymotion
sudo mv /tmp/genymotion.bin /opt/genymotion


# Rofi Launcher
sudo dnf install -y rofi
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd rofi
chmod +x setup.sh
./setup.sh
cd ~ && rm -rf rofi
sed -i "s/theme='style-1'/theme='style-4'/"  ~/.config/rofi/launchers/type-4/launcher.sh

# Polybar
sudo dnf install -y polybar
chmod +x ~/.config/polybar/launch.sh

# Greenclip clipboard manager
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -O /usr/local/bin/greenclip
sudo chmod +x /usr/local/bin/greenclip

