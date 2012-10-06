#!/bin/bash
# Autor: Lara Maia
# Versão: 0.1

aur_command="yaourt --needed --noconfirm -S"
repo_command="pacman --needed --noconfirm -S"
heap=3

function showbar() {
	local i=$(echo "($1 / $2) * 100" | bc -l)
	local i=${i%%.*}; test $i || i=0

	if [ $i -lt 10 ]; then
		echo -ne "\e[42m \e[0m $i % \b\b\b\b\b"
	fi
	
	if [ $i -ge 10 ]; then
		echo -ne "\e[42m \e[0m $i % \b\b\b\b\b\b"
	fi
}

packages_array_all=($(pacman -Qqe))
packages_array_aur=($(pacman -Qqm))
count_packages_all=${#packages_array_all[@]}

echo -e "\nEscaneando\n"
c=0; for package_local in ${packages_array_all[@]}; do
	for package_aur in ${packages_array_aur[@]}; do
		if [ $package_aur == $package_local ]; then
			unset packages_array_all[$c]
		fi
	done
	((c+=1))
	showbar $c $count_packages_all
done; echo -e '\n'

count_packages_all=${#packages_array_all[@]}
count_packages_aur=${#packages_array_aur[@]}

echo -e "Gravando catalogo do aur\n"

echo '#!/bin/bash' > aur_packages.sh
c=0; i=0; for package in "${packages_array_aur[@]}"; do
	if [ $i == 0 ]; then
		echo -en "\n${aur_command} $package" >> aur_packages.sh
		((i+=1))
	elif [ $i -lt ${heap} ]; then
		echo -n " $package" >> aur_packages.sh
		((i+=1))
	else
		echo -ne "\n${aur_command} $package" >> aur_packages.sh
		i=1
	fi
	((c+=1))
	showbar $c $count_packages_aur
done; echo -e '\n'

echo -e "Gravando catalogo de repositórios\n"

echo '#!/bin/bash' > repo_packages.sh
c=0; i=0; for package in "${packages_array_all[@]}"; do
	if [ $i == 0 ]; then
		echo -en "\n${repo_command} $package" >> repo_packages.sh
		((i+=1))
	elif [ $i -lt ${heap} ]; then
		echo -n " $package" >> repo_packages.sh
		((i+=1))
	else
		echo -ne "\n${repo_command} $package" >> repo_packages.sh
		i=1
	fi
	((c+=1))
	showbar $c $count_packages_all
done; echo

echo -e "Operação Completa\n"
