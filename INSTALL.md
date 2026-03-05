# 📦 Полная инструкция по установке

Пошаговое руководство для установки Rai Diamond Store на вашу машину.

## Требования

Перед началом убедитесь, что у вас установлены:

- **Node.js 16+** - https://nodejs.org/
- **Docker & Docker Compose** - https://www.docker.com/
- **Git** (опционально) - https://git-scm.com/
- **Gemini API ключ** - https://makersuite.google.com/app/apikey

## Проверка установки

### Проверить Node.js

```bash
node --version
npm --version
```

Должны вывести версии (например, v18.0.0 и 9.0.0)

### Проверить Docker

```bash
docker --version
docker-compose --version
```

Должны вывести версии

## Пошаговая установка

### Шаг 1: Подготовить проект

#### Вариант A: Клонировать из Git

```bash
git clone https://github.com/your-repo/rai-diamond-store.git
cd rai-diamond-store/site
```

#### Вариант B: Скопировать файлы вручную

```bash
# Скопировать папку site в нужное место
cd site
```

### Шаг 2: Установить зависимости backend

```bash
cd backend
npm install
cd ..
```

**Ожидаемый результат**: Создана папка `backend/node_modules/`

### Шаг 3: Получить Gemini API ключ

1. Открыть https://makersuite.google.com/app/apikey
2. Нажать "Create API Key"
3. Скопировать ключ (выглядит как: `AIzaSyD...`)

### Шаг 4: Настроить переменные окружения

#### Отредактировать `backend/.env`

```bash
# Linux/macOS
nano backend/.env

# Windows (PowerShell)
notepad backend\.env

# Windows (CMD)
notepad backend\.env
```

Содержимое файла:

```env
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=admin123
DB_NAME=bijouterie

# Backend Configuration
PORT=3000
NODE_ENV=development

# Gemini API - ВСТАВЬТЕ ВАШЕ ЗНАЧЕНИЕ
GEMINI_API_KEY=AIzaSyD...your_key_here...
```

**Важно**: Замените `AIzaSyD...your_key_here...` на ваш реальный ключ

### Шаг 5: Запустить PostgreSQL в Docker

```bash
# Запустить контейнер
docker-compose up -d

# Проверить, что контейнер запущен
docker-compose ps
```

**Ожидаемый результат**: Контейнер `bijouterie_db` должен быть в статусе `Up`

### Шаг 6: Проверить подключение к БД

```bash
# Проверить, что БД готова
docker-compose exec postgres pg_isready -U postgres
```

**Ожидаемый результат**: `accepting connections`

### Шаг 7: Запустить backend сервер

```bash
cd backend
npm run dev
```

**Ожидаемый результат**:
```
✓ Backend server running on http://localhost:3000
✓ Frontend available at http://localhost:3000
✓ API available at http://localhost:3000/api
```

### Шаг 8: Проверить работу

Открыть в браузере: **http://localhost:3000**

Должны увидеть:
- ✅ Главную страницу сайта
- ✅ Кнопку чата (💬) в правом нижнем углу
- ✅ Все изображения и стили загружены

## Проверка компонентов

### Проверить API

```bash
# В новом терминале
curl http://localhost:3000/api/health
```

**Ожидаемый результат**:
```json
{"status":"OK","timestamp":"2024-01-15T10:30:00.000Z"}
```

### Проверить товары

```bash
curl http://localhost:3000/api/products
```

**Ожидаемый результат**: JSON массив товаров

### Проверить чат

```bash
curl -X POST http://localhost:3000/api/gemini/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"Привет!"}'
```

**Ожидаемый результат**: JSON с ответом от Gemini

## Решение проблем при установке

### Проблема: "command not found: node"

**Решение**: Node.js не установлен
```bash
# Установить Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Проблема: "command not found: docker"

**Решение**: Docker не установлен
```bash
# Установить Docker
sudo apt-get install -y docker.io docker-compose
sudo usermod -aG docker $USER
newgrp docker
```

### Проблема: "npm ERR! code EACCES"

**Решение**: Проблема с правами доступа
```bash
# Исправить права
sudo chown -R $USER:$USER ~/.npm
npm install
```

### Проблема: "Cannot find module 'express'"

**Решение**: Зависимости не установлены
```bash
cd backend
npm install
```

### Проблема: "Port 3000 is already in use"

**Решение**: Порт занят другим приложением
```bash
# Найти процесс на порту 3000
lsof -i :3000  # Linux/macOS
netstat -ano | findstr :3000  # Windows

# Убить процесс
kill -9 <PID>  # Linux/macOS
taskkill /PID <PID> /F  # Windows

# Или использовать другой порт
# Отредактировать backend/.env
PORT=3001
```

### Проблема: "PostgreSQL connection refused"

**Решение**: БД не запущена
```bash
# Проверить статус
docker-compose ps

# Запустить БД
docker-compose up -d

# Проверить логи
docker-compose logs postgres
```

### Проблема: "GEMINI_API_KEY not configured"

**Решение**: Ключ не установлен в .env
```bash
# Проверить .env
cat backend/.env | grep GEMINI_API_KEY

# Если пусто, отредактировать файл
nano backend/.env
# Добавить: GEMINI_API_KEY=your_key_here
```

### Проблема: "Чат-виджет не появляется"

**Решение**: 
1. Проверить консоль браузера (F12 → Console)
2. Проверить, что файл `js/chat-widget.js` загружается
3. Очистить кэш браузера (Ctrl+Shift+Delete)
4. Перезагрузить страницу (Ctrl+R)

## Первый запуск

### Что должно произойти

1. **Браузер**: Откроется http://localhost:3000
2. **Сайт**: Загрузится главная страница
3. **Чат**: Появится кнопка чата в правом нижнем углу
4. **Тест**: Нажать на кнопку чата и отправить сообщение

### Если что-то не работает

1. Проверить консоль браузера (F12 → Console)
2. Проверить логи backend (в терминале где запущен `npm run dev`)
3. Проверить логи Docker (docker-compose logs)
4. Прочитать [FAQ.md](./FAQ.md)

## Остановка приложения

### Остановить backend

```bash
# Нажать Ctrl+C в терминале где запущен npm run dev
```

### Остановить PostgreSQL

```bash
docker-compose down
```

### Остановить всё

```bash
# Остановить backend (Ctrl+C)
# Остановить PostgreSQL
docker-compose down
```

## Перезапуск приложения

### Быстрый перезапуск

```bash
# Остановить backend (Ctrl+C)
# Запустить снова
cd backend
npm run dev
```

### Полный перезапуск

```bash
# Остановить всё
docker-compose down

# Запустить БД
docker-compose up -d

# Запустить backend
cd backend
npm run dev
```

## Следующие шаги

1. Прочитать [README.md](./README.md) для полного обзора
2. Прочитать [QUICK_START.md](./QUICK_START.md) для быстрого старта
3. Прочитать [CHAT_WIDGET_INTEGRATION.md](./CHAT_WIDGET_INTEGRATION.md) для интеграции чата
4. Прочитать [PAGES_UPDATE.md](./PAGES_UPDATE.md) для добавления чата на другие страницы
5. Прочитать [DEPLOYMENT.md](./DEPLOYMENT.md) для развертывания на production

## Полезные команды

### Просмотреть логи

```bash
# Backend логи
npm run dev

# Docker логи
docker-compose logs -f

# Логи конкретного контейнера
docker-compose logs -f postgres
```

### Проверить статус

```bash
# Статус контейнеров
docker-compose ps

# Статус API
curl http://localhost:3000/api/health

# Статус БД
docker-compose exec postgres pg_isready -U postgres
```

### Очистить данные

```bash
# Удалить контейнер и данные
docker-compose down -v

# Удалить node_modules
rm -rf backend/node_modules

# Переустановить зависимости
cd backend && npm install
```

## Поддержка

Если возникли проблемы:

1. Проверить [FAQ.md](./FAQ.md)
2. Проверить логи
3. Прочитать документацию
4. Создать issue в репозитории

---

**Версия**: 1.0.0  
**Последнее обновление**: 2024-01-15  
**Статус**: Ready to use ✅
