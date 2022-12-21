#!/bin/bash

sudo dnf update

# install core tools
sudo dnf install -y vim tree wget curl tree unzip

# add workstation repository
sudo dnf install -y fedora-workstation-repositories

# install google chrome
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install -y google-chrome-stable

# install zsh
sudo dnf install -y zsh
chsh -s $(which zsh)
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install docker & co
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

sudo usermod -aG docker $USER
newgrp docker

sudo systemctl start docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# install asdf
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

# install alacritty
sudo dnf install -y alacritty

# install ssh server
sudo dnf install -y openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd

# install fonts
curl https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip -L -o /tmp/JetBrainsMono.zip
curl https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip -L -o /tmp/JetBrainsMonoNerdFonts.zip
[[ -d "${HOME}/.local/share/fonts/JetBrainsMono" ]] || mkdir -p "${HOME}/.local/share/fonts/JetBrainsMono"
[[ -d "${HOME}/.local/share/fonts/JetBrainsMonoNerdFonts" ]] || mkdir -p "${HOME}/.local/share/fonts/JetBrainsMonoNerdFonts"
unzip /tmp/JetBrainsMono.zip -d "${HOME}/.local/share/fonts/JetBrainsMono"
unzip /tmp/JetBrainsMonoNerdFonts.zip -d "${HOME}/.local/share/fonts/JetBrainsMonoNerdFonts"
fc-cache -v

# install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

