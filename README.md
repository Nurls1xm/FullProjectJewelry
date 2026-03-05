# Rai Diamond Store - Fullstack E-Commerce Platform

Современный интернет-магазин украшений с AI-ассистентом, построенный на Node.js + Express + PostgreSQL + Google Gemini API.

## 🎯 Особенности

- ✅ **Frontend**: Готовый HTML/CSS/JS сайт (не изменяется)
- ✅ **Backend**: Node.js + Express сервер
- ✅ **База данных**: PostgreSQL в Docker контейнере
- ✅ **AI Ассистент**: Google Gemini API интегрирован в чат-виджет
- ✅ **REST API**: Полнофункциональный API для работы с товарами
- ✅ **Чат-виджет**: Встроенный в сайт, работает в реальном времени
- ✅ **Адаптивный дизайн**: Работает на всех устройствах

## 📁 Структура проекта

```
site/
├── Raihan/                    # Frontend (HTML, CSS, JS, изображения)
│   ├── index.html
│   ├── catalog.html
│   ├── login.html
│   ├── register.html
│   ├── services.html
│   ├── about.html
│   ├── admin-dashboard.html
│   ├── css/
│   │   ├── style.css
│   │   ├── chat-widget.css    # Стили чат-виджета
│   │   └── ...
│   ├── js/
│   │   ├── js.js
│   │   └── chat-widget.js     # Логика чат-виджета
│   ├── imgs/
│   └── icons/
├── backend/                   # Node.js + Express сервер
│   ├── server.js             # Главный файл
│   ├── package.json
│   ├── .env                  # Переменные окружения
│   ├── config/
│   │   └── database.js       # Конфигурация БД
│   ├── routes/
│   │   ├── api.js            # API маршруты
│   │   └── gemini.js         # Gemini маршруты
│   ├── controllers/
│   │   ├── productController.js
│   │   └── chatController.js
│   ├── middleware/
│   │   └── errorHandler.js
│   └── examples/
│       ├── api-examples.md
│       └── database-examples.sql
├── docker-compose.yml        # Docker конфигурация
├── .env                       # Переменные окружения
├── SETUP.md                   # Подробное руководство установки
├── CHAT_WIDGET_INTEGRATION.md # Документация чат-виджета
└── README.md                  # Этот файл
```

## 🚀 Быстрый старт

### Требования

- Node.js 16+ (https://nodejs.org/)
- Docker & Docker Compose (https://www.docker.com/)
- Gemini API ключ (https://makersuite.google.com/app/apikey)

### Установка (Ubuntu 20.04)

```bash
# 1. Установить Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# 2. Установить Docker
sudo apt-get update
sudo apt-get install -y docker.io docker-compose
sudo usermod -aG docker $USER

# 3. Перейти в папку проекта
cd site

# 4. Установить зависимости backend
cd backend
npm install
cd ..

# 5. Запустить PostgreSQL в Docker
docker-compose up -d

# 6. Запустить backend сервер
cd backend
npm run dev
```

Сайт будет доступен по адресу: **http://localhost:3000**

## 📝 Конфигурация

### Переменные окружения (.env)

```env
# Database
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=admin123
DB_NAME=bijouterie

# Backend
PORT=3000
NODE_ENV=development

# Gemini API
GEMINI_API_KEY=your_gemini_api_key_here
```

## 🔌 API Endpoints

### Товары

```bash
# Получить все товары
GET /api/products

# Получить товар по ID
GET /api/products/:id

# Поиск товаров
GET /api/search?query=кольцо
```

### Чат с AI

```bash
# Отправить сообщение
POST /api/gemini/chat
Content-Type: application/json

{
  "message": "Какие украшения у вас есть?"
}
```

### Health Check

```bash
GET /api/health
```

## 💬 Чат-виджет

### Как добавить на страницу

Добавить в `<head>` каждой HTML страницы:

```html
<script src="./js/chat-widget.js" defer></script>
```

### Особенности

- 🎨 Красивый дизайн с градиентом
- 📱 Адаптивный на мобильных устройствах
- ⚡ Работает в реальном времени
- 🤖 Использует Google Gemini API
- 🔒 Безопасен от XSS атак

### Кастомизация

Изменить цвет в `css/chat-widget.css`:

```css
.chat-widget-button {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}
```

Подробнее в [CHAT_WIDGET_INTEGRATION.md](./CHAT_WIDGET_INTEGRATION.md)

## 🗄️ База данных

### Подключение

```javascript
const pool = require('./config/database');

const result = await pool.query('SELECT * FROM products');
```

### Примеры запросов

```sql
-- Получить все товары
SELECT * FROM products;

-- Получить товары по цене
SELECT * FROM products WHERE price BETWEEN 100000 AND 500000;

-- Поиск товаров
SELECT * FROM products WHERE name ILIKE '%кольцо%';
```

Подробнее в [backend/examples/database-examples.sql](./backend/examples/database-examples.sql)

## 🐳 Docker команды

```bash
# Запустить контейнеры
docker-compose up -d

# Остановить контейнеры
docker-compose down

# Просмотреть логи
docker-compose logs -f postgres

# Удалить данные БД
docker-compose down -v

# Перезапустить БД
docker-compose restart postgres
```

## 📦 Backend команды

```bash
cd backend

# Установить зависимости
npm install

# Запустить в режиме разработки
npm run dev

# Запустить в production
npm start
```

## 🧪 Тестирование API

### Используя cURL

```bash
# Получить товары
curl http://localhost:3000/api/products

# Отправить сообщение в чат
curl -X POST http://localhost:3000/api/gemini/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"Привет!"}'
```

### Используя Postman

1. Открыть Postman
2. Создать новый запрос
3. Выбрать метод: GET/POST
4. Ввести URL: `http://localhost:3000/api/products`
5. Нажать "Send"

Подробнее в [backend/examples/api-examples.md](./backend/examples/api-examples.md)

## 🔍 Отладка

### Проверить, что backend запущен

```bash
curl http://localhost:3000/api/health
```

### Просмотреть логи backend

```bash
cd backend
npm run dev
```

### Проверить консоль браузера

1. Открыть DevTools (F12)
2. Перейти на вкладку "Console"
3. Проверить наличие ошибок

### Проверить сетевые запросы

1. Открыть DevTools (F12)
2. Перейти на вкладку "Network"
3. Отправить сообщение в чат
4. Проверить запрос к `/api/gemini/chat`

## 📚 Документация

- [SETUP.md](./SETUP.md) - Подробное руководство установки
- [CHAT_WIDGET_INTEGRATION.md](./CHAT_WIDGET_INTEGRATION.md) - Документация чат-виджета
- [backend/examples/api-examples.md](./backend/examples/api-examples.md) - Примеры API запросов
- [backend/examples/database-examples.sql](./backend/examples/database-examples.sql) - Примеры SQL запросов

## 🛠️ Технологический стек

### Frontend
- HTML5
- CSS3
- JavaScript (Vanilla)
- Swiper.js (для слайдера)

### Backend
- Node.js
- Express.js
- PostgreSQL
- Google Generative AI (Gemini)

### DevOps
- Docker
- Docker Compose
- Ubuntu 20.04

## 🔐 Безопасность

- ✅ CORS включен
- ✅ Body parser для защиты от больших payload
- ✅ Error handling для всех запросов
- ✅ XSS защита в чат-виджете
- ✅ Environment variables для чувствительных данных

## 📈 Производительность

- Статические файлы раздаются напрямую
- Кэширование на уровне браузера
- Оптимизированные SQL запросы
- Асинхронная загрузка чат-виджета

## 🚀 Развертывание на production

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

## 🐛 Решение проблем

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
- Проверить логи: `npm run dev`
- Очистить кэш браузера (Ctrl+Shift+Delete)

## 📞 Поддержка

Для вопросов обратитесь к документации:
- Express: https://expressjs.com/
- PostgreSQL: https://www.postgresql.org/docs/
- Gemini API: https://ai.google.dev/
- Docker: https://docs.docker.com/

## 📄 Лицензия

MIT License - свободно используйте и модифицируйте

## 👥 Автор

Rai Diamond Store Team

---

**Версия**: 1.0.0  
**Последнее обновление**: 2024-01-15  
**Статус**: Production Ready ✅
