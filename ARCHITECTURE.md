# 🏗️ Архитектура Rai Diamond Store

## Обзор системы

```
┌─────────────────────────────────────────────────────────────┐
│                     КЛИЕНТ (БРАУЗЕР)                        │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  HTML/CSS/JS (Raihan/)                               │   │
│  │  - index.html, catalog.html, login.html, etc.        │   │
│  │  - css/ (стили)                                      │   │
│  │  - js/chat-widget.js (чат-виджет)                    │   │
│  │  - imgs/ (изображения)                               │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            ↓ HTTP/HTTPS
┌─────────────────────────────────────────────────────────────┐
│                    BACKEND СЕРВЕР                           │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Node.js + Express (backend/server.js)               │   │
│  │  ┌────────────────────────────────────────────────┐  │   │
│  │  │  Routes                                        │  │   │
│  │  │  - /api/products (GET)                         │  │   │
│  │  │  - /api/products/:id (GET)                     │  │   │
│  │  │  - /api/search (GET)                           │  │   │
│  │  │  - /api/gemini/chat (POST)                     │  │   │
│  │  │  - /api/health (GET)                           │  │   │
│  │  └────────────────────────────────────────────────┘  │   │
│  │  ┌────────────────────────────────────────────────┐  │   │
│  │  │  Controllers                                   │  │   │
│  │  │  - productController.js                        │  │   │
│  │  │  - chatController.js                           │  │   │
│  │  └────────────────────────────────────────────────┘  │   │
│  │  ┌────────────────────────────────────────────────┐  │   │
│  │  │  Middleware                                    │  │   │
│  │  │  - CORS                                        │  │   │
│  │  │  - Body Parser                                 │  │   │
│  │  │  - Error Handler                               │  │   │
│  │  └────────────────────────────────────────────────┘  │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
         ↓ SQL                          ↓ HTTP
┌──────────────────────┐    ┌──────────────────────────┐
│   PostgreSQL БД      │    │  Google Gemini API       │
│  (Docker контейнер)  │    │  (Облачный сервис)      │
│                      │    │                          │
│  - products          │    │  - Обработка текста     │
│  - users             │    │  - Генерация ответов    │
│  - orders            │    │  - AI ассистент         │
│  - order_items       │    │                          │
└──────────────────────┘    └──────────────────────────┘
```

## Компоненты системы

### 1. Frontend (Raihan/)

**Назначение**: Пользовательский интерфейс

**Структура**:
```
Raihan/
├── index.html              # Главная страница
├── catalog.html            # Каталог товаров
├── login.html              # Страница входа
├── register.html           # Регистрация
├── services.html           # Услуги
├── about.html              # О нас
├── admin-dashboard.html    # Админ панель
├── css/
│   ├── style.css           # Основные стили
│   ├── catalog.css         # Стили каталога
│   ├── login.css           # Стили входа
│   ├── register.css        # Стили регистрации
│   ├── services.css        # Стили услуг
│   ├── dashboard.css       # Стили админ панели
│   ├── about.css           # Стили о нас
│   └── chat-widget.css     # Стили чат-виджета
├── js/
│   ├── js.js               # Основной скрипт
│   └── chat-widget.js      # Чат-виджет
├── imgs/                   # Изображения товаров
└── icons/                  # Иконки
```

**Технологии**:
- HTML5
- CSS3
- Vanilla JavaScript
- Swiper.js (слайдер)

**Особенности**:
- Статические файлы
- Не требует сборки
- Работает в любом браузере
- Адаптивный дизайн

### 2. Backend (backend/)

**Назначение**: Обработка запросов, работа с БД, интеграция с API

**Структура**:
```
backend/
├── server.js               # Главный файл сервера
├── package.json            # Зависимости
├── .env                    # Переменные окружения
├── config/
│   └── database.js         # Конфигурация PostgreSQL
├── routes/
│   ├── api.js              # API маршруты
│   └── gemini.js           # Gemini маршруты
├── controllers/
│   ├── productController.js # Логика товаров
│   └── chatController.js    # Логика чата
├── middleware/
│   └── errorHandler.js     # Обработка ошибок
└── examples/
    ├── api-examples.md     # Примеры API
    └── database-examples.sql # Примеры SQL
```

**Технологии**:
- Node.js 16+
- Express.js 4.x
- PostgreSQL драйвер (pg)
- Google Generative AI SDK
- CORS
- Body Parser

**Особенности**:
- RESTful API
- Асинхронная обработка
- Обработка ошибок
- Логирование

### 3. База данных (PostgreSQL)

**Назначение**: Хранение данных приложения

**Структура**:
```
bijouterie (БД)
├── products
│   ├── id (PRIMARY KEY)
│   ├── name
│   ├── description
│   ├── price
│   ├── category
│   ├── image_url
│   └── created_at
├── users
│   ├── id (PRIMARY KEY)
│   ├── name
│   ├── email (UNIQUE)
│   ├── password
│   ├── phone
│   ├── is_active
│   └── created_at
├── orders
│   ├── id (PRIMARY KEY)
│   ├── user_id (FOREIGN KEY)
│   ├── total_amount
│   ├── status
│   └── created_at
└── order_items
    ├── id (PRIMARY KEY)
    ├── order_id (FOREIGN KEY)
    ├── product_id (FOREIGN KEY)
    ├── quantity
    └── price
```

**Особенности**:
- Работает в Docker контейнере
- Автоматическое резервное копирование
- Индексы для оптимизации
- Транзакции для целостности данных

### 4. Google Gemini API

**Назначение**: AI ассистент для чата

**Интеграция**:
```
Пользователь пишет сообщение
         ↓
Чат-виджет отправляет на backend
         ↓
Backend отправляет на Gemini API
         ↓
Gemini обрабатывает и возвращает ответ
         ↓
Backend отправляет ответ на frontend
         ↓
Чат-виджет отображает ответ
```

**Особенности**:
- Обработка естественного языка
- Поддержка нескольких языков
- Контекстные ответы
- Безопасность (API ключ в .env)

## Поток данных

### 1. Загрузка товаров

```
Браузер
  ↓ GET /api/products
Backend (Express)
  ↓ SELECT * FROM products
PostgreSQL
  ↓ Результаты
Backend
  ↓ JSON ответ
Браузер (отображает товары)
```

### 2. Отправка сообщения в чат

```
Пользователь пишет сообщение
  ↓
Чат-виджет (js/chat-widget.js)
  ↓ POST /api/gemini/chat
Backend (controllers/chatController.js)
  ↓ Отправляет на Gemini API
Google Gemini API
  ↓ Обрабатывает текст
Gemini API
  ↓ Возвращает ответ
Backend
  ↓ JSON ответ
Чат-виджет
  ↓ Отображает ответ
```

### 3. Поиск товаров

```
Пользователь вводит поисковый запрос
  ↓
Frontend отправляет GET /api/search?query=...
  ↓
Backend выполняет SQL запрос
  ↓
PostgreSQL возвращает результаты
  ↓
Backend отправляет JSON
  ↓
Frontend отображает результаты
```

## Безопасность

### Frontend
- ✅ XSS защита (textContent вместо innerHTML)
- ✅ CSRF защита (CORS)
- ✅ Валидация входных данных

### Backend
- ✅ CORS включен
- ✅ Body size limit
- ✅ Error handling
- ✅ Environment variables для чувствительных данных
- ✅ SQL injection защита (параметризованные запросы)

### База данных
- ✅ Пароль в .env
- ✅ Ограничение доступа
- ✅ Резервное копирование

### API
- ✅ HTTPS на production
- ✅ Rate limiting (опционально)
- ✅ API ключ для Gemini в .env

## Масштабируемость

### Текущая архитектура
- Single backend instance
- Single PostgreSQL instance
- Подходит для 1000-10000 пользователей

### Для масштабирования

**Горизонтальное масштабирование**:
```
Load Balancer (Nginx)
    ↓
┌───────────────────────────┐
│ Backend Instance 1        │
│ Backend Instance 2        │
│ Backend Instance 3        │
└───────────────────────────┘
    ↓
PostgreSQL (с репликацией)
```

**Вертикальное масштабирование**:
- Увеличить RAM сервера
- Увеличить CPU
- Оптимизировать SQL запросы
- Добавить кэширование (Redis)

## Производительность

### Оптимизация Frontend
- Минификация CSS/JS
- Сжатие изображений
- Кэширование браузера
- CDN для статических файлов

### Оптимизация Backend
- Connection pooling
- Query optimization
- Кэширование результатов
- Асинхронная обработка

### Оптимизация БД
- Индексы на часто используемых полях
- VACUUM ANALYZE
- Партиционирование больших таблиц

## Развертывание

### Development
```
Локальная машина
├── Frontend (http://localhost:3000)
├── Backend (http://localhost:3000/api)
└── PostgreSQL (localhost:5432)
```

### Production
```
Ubuntu Server
├── Nginx (reverse proxy)
├── Node.js + Express (PM2)
├── PostgreSQL (Docker)
└── SSL/TLS (Let's Encrypt)
```

## Мониторинг

### Метрики
- CPU использование
- Память
- Дисковое пространство
- Время ответа API
- Количество ошибок
- Активные соединения БД

### Логирование
- Application logs (PM2)
- Nginx logs
- PostgreSQL logs
- Error tracking

## Резервное копирование

### Стратегия
- Ежедневное резервное копирование БД
- Хранение последних 30 дней
- Тестирование восстановления

### Процесс
```
PostgreSQL
  ↓ pg_dump
Compressed SQL file
  ↓ Сохранение
/var/backups/rai-diamond/
```

## Обновление

### Процесс обновления
1. Создать резервную копию БД
2. Обновить код (git pull)
3. Обновить зависимости (npm install)
4. Перезапустить приложение (pm2 restart)
5. Проверить работоспособность

### Zero-downtime deployment
- Использовать load balancer
- Обновлять по одному instance
- Проверять здоровье перед переключением

## Документация

- [README.md](./README.md) - Обзор проекта
- [SETUP.md](./SETUP.md) - Установка
- [QUICK_START.md](./QUICK_START.md) - Быстрый старт
- [DEPLOYMENT.md](./DEPLOYMENT.md) - Развертывание
- [CHAT_WIDGET_INTEGRATION.md](./CHAT_WIDGET_INTEGRATION.md) - Чат-виджет
- [PAGES_UPDATE.md](./PAGES_UPDATE.md) - Обновление страниц

---

**Версия**: 1.0.0  
**Последнее обновление**: 2024-01-15  
**Статус**: Production Ready ✅
