# WSL/Ubuntu Dev Setup

## Как использовать:

1. **Клонировать репозиторий**:
   ```bash
   git clone https://github.com/yourusername/wsl-ubuntu-setup.git
   cd wsl-ubuntu-setup

2. **Запустить PowerShell-скрипт (от администратора):**
   Set-ExecutionPolicy Bypass -Scope Process -Force
    .\scripts\install-wsl.ps1 

3. **Запустить setup-ubuntu.sh внутри WSL:**
    wsl -d Ubuntu -u devuser
    bash /path/to/setup-ubuntu.sh

---

### Особенности реализации:
1. **Идемпотентность**: Скрипты проверяют установленные пакеты перед повторной установкой.
2. **Доступ к PostgreSQL**: Настроен доступ через `localhost:5432` с паролем.
3. **AstroNvim**: Автоматическая установка LSP-серверов через Mason.
4. **Безопасность**: Пароль пользователя вводится интерактивно, не хранится в скриптах.

Такой подход обеспечивает полное автоматическое развертывание среды за 2 шага с минимальным участием пользователя.