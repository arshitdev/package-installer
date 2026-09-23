#!/usr/bin/env bash

set -e

echo "========== PACKAGE INSTALLER =========="
echo "Checking which Linux distro you use..."

if [ -f /etc/os-release ]; then
	. /etc/os-release
	DISTRO=$ID
else
	echo "Error: Cannot detect Linux Distro"
	exit 1
fi

case "$DISTRO" in
	ubuntu|debian)
		echo "Detected Ubuntu/Debian. Installing the packages..."
		sudo apt-get update -y
		sudo apt-get install -y \
			build-essential git cmake gcc gdb tmux zsh speedtest-cli  \
			python3 python3-pip python3-venv openjdk-17-jdk nodejs npm docker.io \
			htop net-tools zip unzip openssh-client
		;;
	fedora)
		echo "Detected Fedora. Installing the packages..."
		sudo dnf check-update || true
		sudo dnf groupinstall -y "Development Tools"
		sudo dnf install -y \
			cmake gcc-c++ gdb tmux zsh speedtest-cli \
			python3 python3-pip openjdk-17-openjdk nodejs docker \
			htop net-tools zip unzip openssh-clients
		;;
	arch)
		echo "Detected Arch. Installing the packages..."
		sudo pacman -Syu
		sudo pacman -S --noconfirm --needed base-devel
		sudo pacman -S --noconfirm --needed \
			git cmake gcc gdb tmux zsh speedtest-cli \
			python python-pip openjdk-src nodejs docker \
			htop net-tools zip unzip openssh
		;;
	*)
		echo "Error: Unsupported distribution '$DISTRO'."
		exit 1
		;;
esac

echo "========== Installation Complete! =========="
echo "Please restart your terminal once to ensure every effect takes place."
