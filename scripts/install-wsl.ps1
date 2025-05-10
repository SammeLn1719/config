# Требует запуска от администратора
$WSL_IMAGE = "Ubuntu"
$USERNAME = "devuser"
$PASSWORD = Read-Host "Введите пароль для пользователя $USERNAME" -AsSecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($PASSWORD)
$PLAIN_PASSWORD = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

# Включение WSL
if ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State -ne "Enabled") {
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
}

# Установка Ubuntu
if (!(wsl -l | Select-String -Pattern $WSL_IMAGE)) {
    wsl --install -d $WSL_IMAGE
    Start-Sleep -Seconds 20  # Ожидание установки
}

# Создание пользователя в WSL
wsl -d $WSL_IMAGE -u root bash -c "useradd -m -s /bin/bash $USERNAME && echo '$USERNAME:$PLAIN_PASSWORD' | chpasswd && usermod -aG sudo $USERNAME"