#!/bin/bash
# Lara Maia © 2012 ~ 2013 <lara@craft.net.br>
# Contributor: BlackICE <manfredi@gmail.com>
# Versão: 2.0

echo -e "\nAguarde enquanto seu sistema é escaneado...\n"

# Catalog files
repo_file=("repo_packages_dep.cat" "repo_packages_exp.cat")
aur_file=("aur_packages_dep.cat" "aur_packages_exp.cat")

function checkpackages() { # (list, 
	#control variables
	depends=0
	explicit=0
	
	for package in $1; do
		if [ "$(pacman -Qqd $package)" == "$package" ]; then
			eval file="\${${2}_file[0]}"
			((depends+=1))
		else
			eval file="\${${2}_file[1]}"
			((explicit+=1))
		fi
		
		echo $package >> $file
		
		echo -ne "\e[1;32m==>\e[0m Gravando catálogo do $2: "
		echo -ne "\e[1;32m$[$depends+$explicit]"
		echo -ne "\e[0m de \e[1;32m$(echo "$1" | wc -w)\e[0m\r"
	done
	
	
	echo -ne "\n - \e[4;37mPacotes do $2\e[0m: "
	echo -ne "\e[1;33m$explicit\e[0m instalados explicitamente, "
	echo -e  "\e[1;33m$depends\e[0m dependências\n"

}

# Clean files before write
rm -f ${aur_file[@]} ${repo_file[@]}

checkpackages "$(pacman -Qqm)" aur
checkpackages "$(pacman -Qqn)" repo

echo -e "\e[1;32m==>\e[0m Operação concluída\n"
