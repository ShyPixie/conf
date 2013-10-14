#!/bin/bash
# Lara Maia © 2012 ~ 2013 <lara@craft.net.br>
# Contributor: BlackICE <manfredi@gmail.com>
# Versão: 1.3

echo -e "\nAguarde enquanto seu sistema é escaneado..."

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
	
	echo -ne "\e[1;32m==>\e[0m Analisando pacotes: "
	echo -ne "\e[1;32m$c\e[0m de \e[1;32m$count_packages_all\e[0m \r"
done; echo -e "\n"

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
	((c+=1))
	
	echo -ne "\e[1;32m==>\e[0m Gravando catálogo do aur: "
	echo -ne "\e[1;32m$c\e[0m de \e[1;32m$count_packages_aur\e[0m\r"
done

echo -ne "\n - \e[4;37mPacotes do aur\e[0m: "
echo -ne "\e[1;33m$e\e[0m instalados explicitamente, "
echo -e  "\e[1;33m$d\e[0m dependências\n"

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
	((c+=1))
	
	echo -ne "\e[1;32m==>\e[0m Gravando catálogo dos repositórios: "
	echo -ne "\e[1;32m$c\e[0m de \e[1;32m$count_packages_all\e[0m\r"
done

echo -ne "\n - \e[4;37mPacotes oficiais\e[0m: "
echo -ne "\e[1;33m$e\e[0m instalados explicitamente, "
echo -e  "\e[1;33m$d\e[0m dependências\n"

echo -e "\e[1;32m==>\e[0m Operação concluída\n"
