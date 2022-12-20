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
