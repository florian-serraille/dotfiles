#!/bin/bash

function config {
	/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

function clone_repository(){
	git clone --bare git@github.com:florian-serraille/dotfiles.git "${HOME}/.dotfiles"
}

function configure_repository(){
	config checkout
	config config status.showUntrackedFiles no
}

function backup_previous_configuration(){
	if [[ -d "${HOME}/.dotfiles" ]]; then
		echo "Backing up pre-existing dot files."
		config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} "${HOME}/.dotfiles-backup/"{}
	fi
}
function main(){


	clone_repository
	configure_repository
	backup_previous_configuration
	
	bash ~/.local/bin/install_dependencies.sh 
}

main

