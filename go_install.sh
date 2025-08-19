#!/bin/bash

# Скрипт: Установка Go (Golang)
# Автор: Ты! 😎

echo "🚀 Начинаем установку Go..."

# 1. Определяем последнюю версию Go (можно вручную или автоматически)
# Для простоты укажем версию, но можно и автоматизировать
GO_VERSION="1.22.2"
ARCH="amd64"  # Для Intel/AMD. Для Apple M1/M2: arm64
OS="linux"    # Для Linux. macOS: darwin

# 2. Формируем имя файла и URL
FILENAME="go${GO_VERSION}.${OS}-${ARCH}.tar.gz"
URL="https://go.dev/dl/$FILENAME"
echo "Скачиваем: $URL"

# 3. Скачиваем архив
wget "$URL" -O "$FILENAME"

if [ $? -ne 0 ]; then
    echo "❌ Ошибка при скачивании. Проверь URL или подключение к интернету."
    exit 1
fi

echo "✅ Скачано: $FILENAME"

# 4. Удаляем старую версию Go (если есть)
sudo rm -rf /usr/local/go

# 5. Распаковываем в /usr/local
echo "📦 Распаковываем в /usr/local..."
sudo tar -C /usr/local -xzf "$FILENAME"

if [ $? -ne 0 ]; then
    echo "❌ Ошибка при распаковке. Проверь права или целостность архива."
    exit 1
fi

echo "✅ Go распакован в /usr/local/go"

# 6. Добавляем go в PATH (для bash и zsh)
echo "🔧 Добавляем go в PATH..."

# Определяем, какую оболочку использует пользователь
SHELL_TYPE=$(basename "$SHELL")

case "$SHELL_TYPE" in
    "bash")
        RC_FILE="$HOME/.bashrc"
        ;;
    "zsh")
        RC_FILE="$HOME/.zshrc"
        ;;
    *)
        RC_FILE="$HOME/.bashrc"
        echo "⚠️  Неизвестная оболочка, используем .bashrc"
        ;;
esac

# Проверяем, нет ли уже строки с PATH
if ! grep -q "/usr/local/go/bin" "$RC_FILE"; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> "$RC_FILE"
    echo "✅ PATH добавлен в $RC_FILE"
else
    echo "ℹ️  PATH уже добавлен в $RC_FILE"
fi

# 7. Проверяем установку
echo "🔍 Проверяем установку..."
/usr/local/go/bin/go version

if [ $? -eq 0 ]; then
    echo "🎉 Установка завершена! Go успешно установлен."
    echo "💡 Чтобы использовать go в этом терминале, выполни:"
    echo "   source $RC_FILE"
else
    echo "❌ Что-то пошло не так. Попробуй перезапустить терминал."
fi

# 8. Удаляем архив
rm -f "$FILENAME"
echo "🧹 Временный файл удалён"
