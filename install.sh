#!/bin/bash
set -e

project_dir="my_cygwin_environment"


## goto script dir
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

script_dir_parent=${PWD##*/}


main() {
	setup_script ${script_dir_parent}

	install_apt_cyg_package_needed
	install_apt_cyg
	install_base_package
	set_sshd
	install_python
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

install_base_package() {
	echo ">> Install base package"
		source conf/install-base-package
	exit_func $?
}

set_sshd() {
	echo ">> Setup ssh server"
		source conf/set-sshd
	exit_func $?
}

install_python() {
	echo ">> Install python and cia´s"
		source conf/install-python
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
		chmod +x "$0" && ./"$0" "$*"
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
