#!/usr/bin/env bash

set -euo pipefail

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

        if command -v code >/dev/null 2>&1; then
            echo "Visual Studio Code is already installed; skipping it."
        else
            echo "Installing Visual Studio Code..."
            sudo apt-get install -y ca-certificates curl gpg
            sudo install -d -m 0755 /etc/apt/keyrings
            curl -fsSL https://packages.microsoft.com/keys/microsoft.asc |
                sudo gpg --dearmor -o /etc/apt/keyrings/packages.microsoft.gpg
            sudo chmod a+r /etc/apt/keyrings/packages.microsoft.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |
                sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
            sudo apt-get update -y
            sudo apt-get install -y code
        fi
        ;;
    dnf)
        echo "Detected DNF. Installing the packages..."
        sudo dnf check-update || true
        sudo dnf group install -y development-tools
        sudo dnf install -y \
            cmake gcc-c++ gdb tmux zsh speedtest-cli \
            python3 python3-pip temurin-17-jdk nodejs docker \
            htop net-tools zip unzip openssh-clients

        if command -v code >/dev/null 2>&1; then
            echo "Visual Studio Code is already installed; skipping it."
        else
            echo "Installing Visual Studio Code..."
            sudo dnf install -y curl
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            sudo curl -fsSL https://packages.microsoft.com/yumrepos/vscode \
                -o /etc/yum.repos.d/vscode.repo
            sudo dnf install -y code
        fi
        ;;
    pacman)
        echo "Detected Pacman. Installing the packages..."
        sudo pacman -Syu
        sudo pacman -S --noconfirm --needed base-devel
        sudo pacman -S --noconfirm --needed \
            git cmake gcc gdb tmux zsh speedtest-cli \
            python python-pip openjdk-src nodejs docker \
            htop net-tools zip unzip openssh

        if command -v code >/dev/null 2>&1; then
            echo "Visual Studio Code is already installed; skipping it."
        else
            echo "Installing Visual Studio Code..."
            sudo pacman -S --noconfirm --needed code
        fi
        ;;
esac

echo "========== Installation Complete! =========="
echo "Please restart your terminal once to ensure every effect takes place."
