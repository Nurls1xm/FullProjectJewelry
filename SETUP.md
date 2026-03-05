# Rai Diamond Store - Fullstack Setup Guide

## Структура проекта

```
site/
├── Raihan/                    # Frontend (HTML, CSS, JS, изображения)
├── backend/                   # Node.js + Express сервер
│   ├── server.js             # Главный файл сервера
│   ├── package.json          # Зависимости
│   ├── .env                  # Переменные окружения
│   ├── config/
│   │   └── database.js       # Конфигурация PostgreSQL
│   ├── routes/
│   │   ├── api.js            # API маршруты
│   │   └── gemini.js         # Gemini AI маршруты
│   ├── controllers/
│   │   ├── productController.js
│   │   └── chatController.js
│   └── middleware/
│       └── errorHandler.js
├── docker-compose.yml        # Docker конфигурация
└── .env                       # Переменные окружения проекта
```

## Требования

- Node.js 16+ (https://nodejs.org/)
- Docker & Docker Compose (https://www.docker.com/)
- PostgreSQL 13+ (или использовать Docker)
- Gemini API ключ (https://makersuite.google.com/app/apikey)

## Установка на Ubuntu 20.04

### 1. Установить Node.js

```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
node --version
npm --version
```

### 2. Установить Docker

```bash
sudo apt-get update
sudo apt-get install -y docker.io docker-compose
sudo usermod -aG docker $USER
newgrp docker
docker --version
docker-compose --version
```

### 3. Клонировать/подготовить проект

```bash
cd site
```

### 4. Установить зависимости backend

```bash
cd backend
npm install
cd ..
```

### 5. Получить Gemini API ключ

1. Перейти на https://makersuite.google.com/app/apikey
2. Нажать "Create API Key"
3. Скопировать ключ

### 6. Настроить переменные окружения

Обновить `site/backend/.env`:

```env
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=admin123
DB_NAME=bijouterie
PORT=3000
NODE_ENV=development
GEMINI_API_KEY=your_actual_gemini_api_key_here
```

## Запуск проекта

### Вариант 1: С Docker (рекомендуется)

```bash
cd site

# Запустить PostgreSQL в Docker
docker-compose up -d

# Проверить, что БД запустилась
docker-compose logs postgres

# Установить зависимости backend
cd backend
npm install
cd ..

# Запустить backend сервер
cd backend
npm run dev
```

Сайт будет доступен по адресу: **http://localhost:3000**

### Вариант 2: Без Docker (локальный PostgreSQL)

```bash
# Убедиться, что PostgreSQL запущен локально
sudo systemctl start postgresql

# Создать базу данных (если её нет)
sudo -u postgres psql -c "CREATE DATABASE bijouterie;"

# Установить зависимости
cd site/backend
npm install

# Запустить сервер
npm run dev
```

## Команды

### Docker команды

```bash
# Запустить контейнеры
docker-compose up -d

# Остановить контейнеры
docker-compose down

# Просмотреть логи
docker-compose logs -f postgres

# Удалить данные БД
docker-compose down -v
```

### Backend команды

```bash
cd site/backend

# Установить зависимости
npm install

# Запустить в режиме разработки
npm run dev

# Запустить в production
npm start
```

## API Endpoints

### Товары

```bash
# Получить все товары
curl http://localhost:3000/api/products

# Получить товар по ID
curl http://localhost:3000/api/products/1

# Поиск товаров
curl "http://localhost:3000/api/search?query=кольцо"
```

### Чат с AI

```bash
# Отправить сообщение Gemini
curl -X POST http://localhost:3000/api/gemini/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"Какие украшения у вас есть?"}'
```

### Health Check

```bash
curl http://localhost:3000/api/health
```

## Примеры кода

### Подключение к PostgreSQL (backend/config/database.js)

```javascript
const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

module.exports = pool;
```

### API маршрут (backend/routes/api.js)

```javascript
const express = require('express');
const router = express.Router();
const productController = require('../controllers/productController');

router.get('/products', productController.getAllProducts);
router.get('/products/:id', productController.getProductById);
router.get('/search', productController.searchProducts);

module.exports = router;
```

### Запрос к Gemini API (backend/controllers/chatController.js)

```javascript
const { GoogleGenerativeAI } = require('@google/generative-ai');

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

exports.sendMessage = async (req, res) => {
  const { message } = req.body;
  const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
  
  const result = await model.generateContent({
    contents: [{
      role: 'user',
      parts: [{ text: message }],
    }],
  });

  res.json({ response: result.response.text() });
};
```

### Чат-виджет (Raihan/js/chat-widget.js)

```javascript
class ChatWidget {
  constructor() {
    this.isOpen = false;
    this.init();
  }

  async sendMessage() {
    const message = document.getElementById('chatInput').value;
    
    const response = await fetch('/api/gemini/chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ message }),
    });

    const data = await response.json();
    this.addMessage(data.response, 'bot');
  }
}

new ChatWidget();
```

## Проверка работы

1. Открыть http://localhost:3000 в браузере
2. Проверить, что сайт загружается корректно
3. Нажать на кнопку чата (💬) в правом нижнем углу
4. Написать сообщение и отправить
5. Проверить, что ответ приходит от Gemini AI

## Решение проблем

### PostgreSQL не подключается

```bash
# Проверить статус контейнера
docker-compose ps

# Просмотреть логи
docker-compose logs postgres

# Перезапустить
docker-compose restart postgres
```

### Gemini API ошибка

- Проверить, что GEMINI_API_KEY установлен в .env
- Убедиться, что ключ активен на https://makersuite.google.com/app/apikey
- Проверить лимиты API

### Сайт не загружается

- Проверить, что backend запущен: `curl http://localhost:3000/api/health`
- Проверить логи: `npm run dev` (должны быть видны логи)
- Очистить кэш браузера (Ctrl+Shift+Delete)

### Чат-виджет не работает

- Проверить консоль браузера (F12 → Console)
- Убедиться, что `/js/chat-widget.js` загружается
- Проверить, что `/api/gemini/chat` доступен

## Развертывание на production

### Используя PM2

```bash
npm install -g pm2

cd site/backend
pm2 start server.js --name "rai-diamond-api"
pm2 save
pm2 startup
```

### Используя Nginx

```bash
sudo apt-get install nginx

# Создать конфиг /etc/nginx/sites-available/rai-diamond
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

sudo ln -s /etc/nginx/sites-available/rai-diamond /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## Поддержка

Для вопросов и проблем обратитесь к документации:
- Express: https://expressjs.com/
- PostgreSQL: https://www.postgresql.org/docs/
- Gemini API: https://ai.google.dev/
