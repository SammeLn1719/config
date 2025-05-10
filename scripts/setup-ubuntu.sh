#!/bin/bash

# Обновление системы
sudo apt update && sudo apt upgrade -y

# Установка зависимостей
packages=(
    "curl" 
    "docker.io"
    "postgresql" 
    "postgresql-contrib"
    "neovim"
    "gcc"
    "make"
)

for pkg in "${packages[@]}"; do
    if ! dpkg -l | grep -q "^ii  $pkg "; then
        sudo apt install -y $pkg
    fi
done

# Установка Go (последняя версия)
if ! command -v go &> /dev/null; then
    sudo rm -rf /usr/local/go
    curl -LO https://go.dev/dl/$(curl -s https://go.dev/VERSION?m=text).linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go*.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
fi

# Установка Node.js
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Настройка PostgreSQL
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo -u postgres psql -c "CREATE USER $USER WITH PASSWORD '$PLAIN_PASSWORD';"
sudo -u postgres psql -c "CREATE DATABASE devdb;"
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/*/main/postgresql.conf
echo "host all all 0.0.0.0/0 scram-sha-256" | sudo tee -a /etc/postgresql/*/main/pg_hba.conf
sudo systemctl restart postgresql

# Установка AstroNvim
if [ ! -d ~/.config/nvim ]; then
    git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
    cp /path/to/repo/nvim/init.lua ~/.config/nvim/lua/user/init.lua
    nvim --headless -c 'quitall'  # Запуск для установки плагинов
fi

# Настройка Docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker