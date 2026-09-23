#!/usr/bin/env bash

set -e

echo "========== PACKAGE INSTALLER =========="
echo "Checking which package manager is available..."

if command -v apt-get >/dev/null 2>&1; then
    PKG_MANAGER="apt-get"
elif command -v dnf >/dev/null 2>&1; then
    PKG_MANAGER="dnf"
elif command -v pacman >/dev/null 2>&1; then
    PKG_MANAGER="pacman"
else
    echo "Error: No supported package manager found."
    exit 1
fi

case "$PKG_MANAGER" in
    apt-get)
        echo "Detected APT. Installing the packages..."
        sudo apt-get update -y
        sudo apt-get install -y \
            build-essential git cmake gcc gdb tmux zsh speedtest-cli \
            python3 python3-pip python3-venv openjdk-17-jdk nodejs npm docker.io \
            htop net-tools zip unzip openssh-client
        ;;
    dnf)
        echo "Detected DNF. Installing the packages..."
        sudo dnf check-update || true
        sudo dnf group install -y development-tools
        sudo dnf install -y \
            cmake gcc-c++ gdb tmux zsh speedtest-cli \
            python3 python3-pip temurin-17-jdk nodejs docker \
            htop net-tools zip unzip openssh-clients
        ;;
    pacman)
        echo "Detected Pacman. Installing the packages..."
        sudo pacman -Syu
        sudo pacman -S --noconfirm --needed base-devel
        sudo pacman -S --noconfirm --needed \
            git cmake gcc gdb tmux zsh speedtest-cli \
            python python-pip openjdk-src nodejs docker \
            htop net-tools zip unzip openssh
        ;;
esac

echo "========== Installation Complete! =========="
echo "Please restart your terminal once to ensure every effect takes place."

