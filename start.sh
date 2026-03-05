#!/bin/bash

# Rai Diamond Store - Quick Start Script

echo "🚀 Rai Diamond Store - Fullstack Setup"
echo "======================================"

# Проверить Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не установлен. Установите Docker: https://www.docker.com/"
    exit 1
fi

# Проверить Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js не установлен. Установите Node.js: https://nodejs.org/"
    exit 1
fi

echo "✓ Docker найден"
echo "✓ Node.js найден"

# Запустить PostgreSQL в Docker
echo ""
echo "📦 Запуск PostgreSQL в Docker..."
docker-compose up -d

# Ждать, пока БД запустится
echo "⏳ Ожидание запуска БД..."
sleep 5

# Проверить подключение
if docker-compose exec -T postgres pg_isready -U postgres > /dev/null 2>&1; then
    echo "✓ PostgreSQL запущен"
else
    echo "❌ PostgreSQL не запустился"
    exit 1
fi

# Установить зависимости backend
echo ""
echo "📚 Установка зависимостей backend..."
cd backend
npm install

if [ $? -eq 0 ]; then
    echo "✓ Зависимости установлены"
else
    echo "❌ Ошибка при установке зависимостей"
    exit 1
fi

# Проверить .env файл
if [ ! -f ".env" ]; then
    echo ""
    echo "⚠️  Файл .env не найден!"
    echo "Пожалуйста, создайте файл backend/.env с переменными окружения:"
    echo ""
    echo "DB_HOST=localhost"
    echo "DB_PORT=5432"
    echo "DB_USER=postgres"
    echo "DB_PASSWORD=admin123"
    echo "DB_NAME=bijouterie"
    echo "PORT=3000"
    echo "NODE_ENV=development"
    echo "GEMINI_API_KEY=your_gemini_api_key_here"
    echo ""
    exit 1
fi

# Запустить backend
echo ""
echo "🚀 Запуск backend сервера..."
echo ""
echo "✓ Сервер запущен на http://localhost:3000"
echo "✓ API доступен на http://localhost:3000/api"
echo "✓ Чат-виджет встроен в сайт"
echo ""
echo "Нажмите Ctrl+C для остановки сервера"
echo ""

npm run dev
