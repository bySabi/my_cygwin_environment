#!/bin/bash
set -e
set +x

project_dir="my_cygwin_environment"


## goto script dir
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

script_dir_parent=${PWD##*/}


main() {
	setup_script ${script_dir_parent}

	install_apt_cyg_package_needed
	install_apt_cyg
	install_python
	install_pexpect
#	set_sshd
#	set_bash
#	install_git_crypt
#	set_gitconfig
#	set_develop_dir
#	set_ssh_keys_dir
#	set_git_crypt_keys_dir
}

install_apt_cyg_package_needed() {
	echo ">> Install apt-cyg package needed"
		source conf/apt-cyg-package-needed
	exit_func $?
}

install_apt_cyg() {
	echo ">> Install apt-cyg"
		source conf/install-apt-cyg
	exit_func $?
}

install_python() {
	echo ">> Install python and cia´s"
		source conf/install-python
	exit_func $?
}

install_pexpect() {
	echo ">> Install pexpect"
		source conf/install-pexpect
	exit_func $?
}

set_sshd() {
	echo ">> Setup ssh server"
		source conf/set-sshd
	exit_func $?
}

set_bashrc() {
	echo ">> Set \".bashrc\" for user: ${USER}"
		source conf/set-bashrc
	exit_func $?
}

install_git_crypt() {
	echo ">> Install git-crypt"
		sudo bash conf/install-git-crypt
	exit_func $?
}

set_gitconfig() {
	echo ">> Set \".gitconfig\" for user: ${USER}"
		install -m 644 conf/gitconfig ${HOME}/.gitconfig
	exit_func $?
}

set_develop_dir() {
	echo ">> Create \"develop\" dir for user: ${USER}"
		mkdir -p ${HOME}/develop
	exit_func $?	
}

set_ssh_keys_dir() {
	echo ">> Setup \".ssh\" dir for user: ${USER}"
		source conf/set-ssh-dir
	exit_func $?
}

set_git_crypt_keys_dir() {
	echo ">> Setup \".git-crypt\" dir for user: ${USER}"
		source conf/set-git-crypt-dir
	exit_func $?
}

install_git() {
	echo ">> Install git"
		source conf/install-git
	exit_func $?
}

setup_script() {
	if [ "$1" != ${project_dir} ]; then
		if ! which git > /dev/null
		then
			install_git
		fi
		echo ">> clone \"${project_dir}\" repo"
			[ -d ${project_dir} ] && rm -fr ${project_dir}
			git clone https://github.com/bySabi/${project_dir}.git
		exit_func $?
		cd ${project_dir}
		chmod +x install.sh && ./install.sh
		exit 0
	fi
}

exit_func() {
	local exitcode=${1}
	if [ $exitcode == 0 ]; then 
		echo -e "\e[00;32mOK\e[00m"
	else 
		echo -e "\e[00;31mFAIL\e[00m"
	fi
}


main "$@"
exit 0
