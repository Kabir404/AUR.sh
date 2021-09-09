#!/bin/bash

pkgname=$1

RED="\033[0;31m"
GRE="\O33[0;33m"
WHI="\033[1;37m"
NC="\033[0m" # No Color


if (( $EUID == 0 )); then
    echo -e "${RED}==> ${WHI}This script should not be run as root"
    exit
fi


echo -e "${RED}==> ${WHI}Cloning Installation files of $pkgname ${NC}"

git clone "https://aur.archlinux.org/$pkgname.git" >> /dev/null


echo -e "${RED}==> ${WHI}Installing $pkgname ${NC}"
cd $pkgname
makepkg -si

echo -e "${RED}==> ${WHI}Cleaning up..${NC}"
cd ..
rm -rf  $pkgname
