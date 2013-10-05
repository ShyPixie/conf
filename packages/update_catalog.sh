#!/bin/bash
# Lara Maia © 2012
# Versão: 1.2

echo

packages_array_all=($(pacman -Qq))
packages_array_aur=($(pacman -Qqm))
count_packages_all=${#packages_array_all[@]}

c=0; for package_local in ${packages_array_all[@]}; do
	for package_aur in ${packages_array_aur[@]}; do
		if [ $package_aur == $package_local ]; then
			unset packages_array_all[$c]
		fi
	done
	((c+=1))
	echo -ne "Escaneando: $c de $count_packages_all\r"
done; echo -e '\n'

count_packages_all=${#packages_array_all[@]}
count_packages_aur=${#packages_array_aur[@]}
repo_file=("repo_packages_dep.cat" "repo_packages_exp.cat")
aur_file=("aur_packages_dep.cat" "aur_packages_exp.cat")

function checkpackage() {
	local param=$(LANG=en_US pacman -Qi $1 | \
	            grep Reason | awk '{print tolower($4)}')
	            
	if [ "$param" == "installed" ]; then
		param='dependency'
	fi
	
	echo "$param"
}

echo -n > ${aur_file[0]}; echo -n > ${aur_file[1]}
c=0; d=0; e=0; for package in "${packages_array_aur[@]}"; do
	type=$(checkpackage $package)
	if [ $type == "dependency" ]; then
		echo "$package" >> ${aur_file[0]}
		((d+=1))
	else
		echo "$package" >> ${aur_file[1]}
		((e+=1))
	fi
	((c+=1)); echo -ne "Gravando catalogo do aur: $c de $count_packages_aur\r"
done
echo -e "Pacotes do aur: $e instalados explicitamente, $d dependências\n"

echo -n > ${repo_file[0]}; echo -n > ${repo_file[1]}
c=0; d=0; e=0; for package in "${packages_array_all[@]}"; do
	type=$(checkpackage $package)
	if [ $type == "dependency" ]; then
		echo "$package" >> ${repo_file[0]}
		((d+=1))
	else
		echo "$package" >> ${repo_file[1]}
		((e+=1))
	fi
	((c+=1)); echo -ne "Gravando catalogo dos repositórios: $c de $count_packages_all\r"
done
echo -e "Pacotes oficiais: $e instalados explicitamente, $d dependências\n"

echo -e "Operação Completa\n"
