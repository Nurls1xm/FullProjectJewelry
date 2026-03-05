# 📂 Обзор всех файлов проекта

## Структура проекта

```
site/
├── 📄 Документация (13 файлов)
├── 🐳 Docker конфигурация
├── 🔧 Backend (Node.js + Express)
├── 🎨 Frontend (HTML/CSS/JS)
└── 📦 Конфигурация
```

---

## 📄 Документация (13 файлов)

### Начните отсюда

| Файл | Назначение | Для кого |
|------|-----------|---------|
| **START_HERE.md** | Начните отсюда! | Все |
| **QUICK_START.md** | Запуск за 5 минут | Нетерпеливые |
| **README.md** | Полный обзор проекта | Все |

### Установка и конфигурация

| Файл | Назначение | Для кого |
|------|-----------|---------|
| **INSTALL.md** | Пошаговая установка | Новички |
| **SETUP.md** | Подробная конфигурация | Опытные |
| **PROJECT_SUMMARY.md** | Резюме проекта | Все |

### Использование

| Файл | Назначение | Для кого |
|------|-----------|---------|
| **FAQ.md** | Часто задаваемые вопросы | Все |
| **PAGES_UPDATE.md** | Обновление HTML страниц | Frontend разработчики |
| **CHAT_WIDGET_INTEGRATION.md** | Интеграция чат-виджета | Frontend разработчики |

### Архитектура и развертывание

| Файл | Назначение | Для кого |
|------|-----------|---------|
| **ARCHITECTURE.md** | Архитектура системы | Архитекторы |
| **DEPLOYMENT.md** | Развертывание на production | DevOps инженеры |
| **FILES_OVERVIEW.md** | Этот файл | Все |

### Примеры

| Файл | Назначение | Для кого |
|------|-----------|---------|
| **backend/examples/api-examples.md** | Примеры API запросов | Backend разработчики |
| **backend/examples/database-examples.sql** | Примеры SQL запросов | DBA |

---

## 🐳 Docker конфигурация

### docker-compose.yml
```yaml
# Конфигурация для запуска PostgreSQL в Docker контейнере
# Сервис: postgres (bijouterie_db)
# Порт: 5432
# Пользователь: postgres
# Пароль: admin123
# БД: bijouterie
```

**Использование**:
```bash
docker-compose up -d      # Запустить
docker-compose down       # Остановить
docker-compose logs -f    # Логи
```

---

## 🔧 Backend (Node.js + Express)

### Главные файлы

#### backend/server.js
```javascript
// Главный файл сервера
// - Инициализирует Express приложение
// - Подключает middleware (CORS, Body Parser)
// - Раздает статические файлы из Raihan/
// - Подключает API маршруты
// - Запускает сервер на порту 3000
```

**Размер**: ~50 строк  
**Зависимости**: express, cors, body-parser, path

#### backend/package.json
```json
{
  "name": "rai-diamond-backend",
  "version": "1.0.0",
  "dependencies": {
    "express": "^4.18.2",
    "pg": "^8.11.3",
    "dotenv": "^16.3.1",
    "cors": "^2.8.5",
    "body-parser": "^1.20.2",
    "@google/generative-ai": "^0.3.0"
  }
}
```

**Установка**: `npm install`

#### backend/.env
```env
# Переменные окружения для backend
# - DB_HOST, DB_PORT, DB_USER, DB_PASSWORD, DB_NAME
# - PORT, NODE_ENV
# - GEMINI_API_KEY
```

**Важно**: Не коммитить в Git!

### Конфигурация

#### backend/config/database.js
```javascript
// Конфигурация подключения к PostgreSQL
// - Использует pg.Pool для управления соединениями
// - Читает переменные из .env
// - Обрабатывает ошибки подключения
```

**Размер**: ~20 строк  
**Экспорт**: pool (для использования в других файлах)

### Маршруты (Routes)

#### backend/routes/api.js
```javascript
// API маршруты для товаров
// GET /api/products - получить все товары
// GET /api/products/:id - получить товар по ID
// GET /api/search - поиск товаров
// GET /api/health - проверка статуса
```

**Размер**: ~20 строк  
**Контроллер**: productController

#### backend/routes/gemini.js
```javascript
// Маршруты для Gemini AI
// POST /api/gemini/chat - отправить сообщение
```

**Размер**: ~10 строк  
**Контроллер**: chatController

### Контроллеры (Controllers)

#### backend/controllers/productController.js
```javascript
// Логика работы с товарами
// - getAllProducts() - получить все товары
// - getProductById() - получить товар по ID
// - searchProducts() - поиск товаров
```

**Размер**: ~50 строк  
**БД запросы**: SELECT * FROM products

#### backend/controllers/chatController.js
```javascript
// Логика работы с чатом
// - sendMessage() - отправить сообщение в Gemini API
```

**Размер**: ~40 строк  
**API**: Google Generative AI (Gemini)

### Middleware

#### backend/middleware/errorHandler.js
```javascript
// Обработка ошибок
// - Логирует ошибки
// - Возвращает JSON ответ с ошибкой
```

**Размер**: ~15 строк  
**Использование**: app.use(errorHandler)

### Примеры

#### backend/examples/api-examples.md
```markdown
# Примеры API запросов
- Health check
- Получить товары
- Получить товар по ID
- Поиск товаров
- Отправить сообщение в чат
- JavaScript примеры
- cURL примеры
- Обработка ошибок
```

**Размер**: ~400 строк  
**Формат**: Markdown с примерами

#### backend/examples/database-examples.sql
```sql
-- Примеры SQL запросов
-- SELECT, INSERT, UPDATE, DELETE
-- JOIN запросы
-- Агрегирующие функции
-- Полезные команды
```

**Размер**: ~200 строк  
**Формат**: SQL

---

## 🎨 Frontend (HTML/CSS/JS)

### Главные файлы (не изменялись)

#### Raihan/index.html
```html
<!-- Главная страница -->
<!-- Обновлена: добавлен скрипт чат-виджета -->
```

#### Raihan/catalog.html
```html
<!-- Каталог товаров -->
<!-- Обновлена: добавлен скрипт чат-виджета -->
```

#### Raihan/login.html
```html
<!-- Страница входа -->
<!-- Обновлена: добавлен скрипт чат-виджета -->
```

#### Raihan/register.html
```html
<!-- Страница регистрации -->
<!-- Обновлена: добавлен скрипт чат-виджета -->
```

#### Raihan/services.html
```html
<!-- Услуги -->
<!-- Обновлена: добавлен скрипт чат-виджета -->
```

#### Raihan/about.html
```html
<!-- О нас -->
<!-- Обновлена: добавлен скрипт чат-виджета -->
```

#### Raihan/admin-dashboard.html
```html
<!-- Админ панель -->
<!-- Обновлена: добавлен скрипт чат-виджета -->
```

### Новые файлы

#### Raihan/js/chat-widget.js
```javascript
// Чат-виджет AI ассистента
// - Класс ChatWidget
// - Методы: init, createWidget, attachEventListeners
// - Методы: toggleChat, openChat, closeChat
// - Методы: sendMessage, addMessage, showLoading
// - Интеграция с /api/gemini/chat
```

**Размер**: ~200 строк  
**Зависимости**: Нет (Vanilla JavaScript)  
**Загрузка**: defer (асинхронная)

#### Raihan/css/chat-widget.css
```css
/* Стили чат-виджета */
/* - .chat-widget-container (позиция) */
/* - .chat-widget-button (кнопка) */
/* - .chat-widget-window (окно чата) */
/* - .chat-widget-header (заголовок) */
/* - .chat-widget-messages (сообщения) */
/* - .chat-widget-input-area (ввод) */
/* - Анимации (slideUp, fadeIn, bounce) */
```

**Размер**: ~300 строк  
**Адаптивность**: Мобильные устройства  
**Цвета**: Градиент фиолетовый

### Существующие файлы (не изменялись)

#### Raihan/js.js
```javascript
// Основной скрипт сайта
// - Навигация
// - Слайдер (Swiper)
// - Корзина товаров
// - Интерактивность
```

#### Raihan/css/style.css
```css
/* Основные стили сайта */
```

#### Raihan/css/catalog.css
```css
/* Стили каталога */
```

#### Raihan/css/login.css
```css
/* Стили страницы входа */
```

#### Raihan/css/register.css
```css
/* Стили страницы регистрации */
```

#### Raihan/css/services.css
```css
/* Стили услуг */
```

#### Raihan/css/about.css
```css
/* Стили о нас */
```

#### Raihan/css/dashboard.css
```css
/* Стили админ панели */
```

#### Raihan/imgs/
```
Папка с изображениями товаров и фоны
- item1.png - item16.png (товары)
- s1.png - s3.png (слайдер)
- service1.png - service3.png (услуги)
- bg.jpg, bg.mp4 (фоны)
- hero.png (герой)
- logo.jpg (логотип)
- И другие...
```

#### Raihan/icons/
```
Папка с иконками
- instagram.svg
- phone.svg
- whatsapp.svg
```

---

## 📦 Конфигурация

### .env (корневой)
```env
# Переменные окружения для всего проекта
# - DB_HOST, DB_PORT, DB_USER, DB_PASSWORD, DB_NAME
# - PORT, NODE_ENV
# - GEMINI_API_KEY
```

**Важно**: Не коммитить в Git!

### Raihan/package.json
```json
{
  "name": "rai-diamond-store",
  "version": "1.0.0",
  "scripts": {
    "backend": "cd backend && npm run dev",
    "backend:install": "cd backend && npm install",
    "docker:up": "docker-compose up -d",
    "docker:down": "docker-compose down"
  }
}
```

---

## 📊 Статистика файлов

### Документация
- Всего: 13 файлов
- Строк: ~5000
- Размер: ~500 KB

### Backend
- Всего: 8 файлов
- Строк: ~500
- Размер: ~50 KB

### Frontend (новые)
- Всего: 2 файла
- Строк: ~500
- Размер: ~50 KB

### Конфигурация
- Всего: 3 файла
- Размер: ~10 KB

### Итого
- Всего файлов: 26+
- Строк кода: ~1000
- Размер: ~600 KB

---

## 🔍 Как найти нужный файл

### Нужно запустить проект?
→ [START_HERE.md](./START_HERE.md) или [QUICK_START.md](./QUICK_START.md)

### Нужна помощь с установкой?
→ [INSTALL.md](./INSTALL.md)

### Нужна документация по API?
→ [backend/examples/api-examples.md](./backend/examples/api-examples.md)

### Нужны примеры SQL?
→ [backend/examples/database-examples.sql](./backend/examples/database-examples.sql)

### Нужно развернуть на production?
→ [DEPLOYMENT.md](./DEPLOYMENT.md)

### Нужно понять архитектуру?
→ [ARCHITECTURE.md](./ARCHITECTURE.md)

### Нужно интегрировать чат?
→ [CHAT_WIDGET_INTEGRATION.md](./CHAT_WIDGET_INTEGRATION.md)

### Есть вопросы?
→ [FAQ.md](./FAQ.md)

---

## 📝 Порядок чтения документации

1. **START_HERE.md** - Начните отсюда
2. **QUICK_START.md** - Быстрый старт
3. **README.md** - Полный обзор
4. **INSTALL.md** - Если нужна помощь с установкой
5. **FAQ.md** - Если есть вопросы
6. **ARCHITECTURE.md** - Если нужно понять архитектуру
7. **DEPLOYMENT.md** - Если нужно развернуть на production

---

## 🔐 Важные файлы

### Не коммитить в Git
- `backend/.env` - Содержит API ключи
- `site/.env` - Содержит пароли БД
- `backend/node_modules/` - Зависимости

### Добавить в .gitignore
```
backend/.env
site/.env
backend/node_modules/
.DS_Store
*.log
```

---

## 📦 Размеры файлов

| Файл | Размер |
|------|--------|
| backend/server.js | ~2 KB |
| backend/controllers/chatController.js | ~1.5 KB |
| backend/controllers/productController.js | ~1.5 KB |
| Raihan/js/chat-widget.js | ~8 KB |
| Raihan/css/chat-widget.css | ~6 KB |
| Документация | ~500 KB |
| **Итого** | **~600 KB** |

---

## 🚀 Быстрые команды

```bash
# Установить зависимости
cd site/backend && npm install

# Запустить БД
docker-compose up -d

# Запустить backend
cd site/backend && npm run dev

# Проверить API
curl http://localhost:3000/api/health

# Остановить БД
docker-compose down
```

---

**Версия**: 1.0.0  
**Последнее обновление**: 2024-01-15  
**Статус**: Complete ✅
