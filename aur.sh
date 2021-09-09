#!/bin/bash

pkgname=$2

RED="\033[0;31m"
WHI="\033[1;37m"
NC="\033[0m" # No Color


if (( $EUID == 0 )); then
    echo -e "${RED}==> ${WHI}This script should not be run as root"
    exit
fi

function Help(){
echo "Welcome to AUR.sh"
echo "This is a simple Arch Linux AUR package installer"
echo "Even though it can Install(Using MakePKG) and Remove using PacMan"
echo "Its still not suited for normal use and you should use a Real AUR Helper"
echo "Like YAY"
echo "________________________________________________________________________"
echo "-h                | Shows this message"
echo "-i {Package Name} | Installs package from aur.archlinux.org"
echo "-r {Package Name} | Removes installed package using PacMan"
echo "________________________________________________________________________"
}


function Clean(){
echo -e "${RED}==> ${WHI}Cleaning up..${NC}"
cd ..
rm -rf  $pkgname >> /dev/null
}

function Install(){
echo -e "${RED}==> ${WHI}Cloning Installation files of $pkgname ${NC}"

git clone "https://aur.archlinux.org/$pkgname.git" >> /dev/null


echo -e "${RED}==> ${WHI}Installing $pkgname ${NC}"
cd $pkgname
makepkg -si

Clean
}

function Remove(){
echo -e "${RED}==> ${WHI}Uninstalling $pkgname ${NC}"
sudo pacman -Rns $pkgname
}

# Get the options
while getopts ":h:i:r" option; do
   case $option in
      h) # display Help
         Help;;
      i) # install program
         Install;;
      r) # remove program
         Remove;;
      \?) # Invalid option
         echo "Error: Invalid option. run the command again with the -i argument";;
   esac
done

exit
