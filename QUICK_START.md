# 🚀 Быстрый старт - Rai Diamond Store

## За 5 минут до запуска

### Шаг 1: Установить зависимости (1 минута)

```bash
cd site/backend
npm install
cd ..
```

### Шаг 2: Запустить PostgreSQL (1 минута)

```bash
docker-compose up -d
```

### Шаг 3: Получить Gemini API ключ (2 минуты)

1. Перейти на https://makersuite.google.com/app/apikey
2. Нажать "Create API Key"
3. Скопировать ключ

### Шаг 4: Настроить .env (1 минута)

Отредактировать `site/backend/.env`:

```env
GEMINI_API_KEY=your_actual_key_here
```

### Шаг 5: Запустить сервер

```bash
cd site/backend
npm run dev
```

**Готово!** Сайт доступен на http://localhost:3000

---

## Команды для разных операционных систем

### Linux / macOS

```bash
# Установить зависимости
cd site/backend && npm install && cd ..

# Запустить PostgreSQL
docker-compose up -d

# Запустить backend
cd site/backend && npm run dev
```

### Windows (PowerShell)

```powershell
# Установить зависимости
cd site/backend; npm install; cd ..

# Запустить PostgreSQL
docker-compose up -d

# Запустить backend
cd site/backend; npm run dev
```

### Windows (CMD)

```cmd
# Установить зависимости
cd site\backend && npm install && cd ..

# Запустить PostgreSQL
docker-compose up -d

# Запустить backend
cd site\backend && npm run dev
```

---

## Проверка работы

### 1. Проверить backend

```bash
curl http://localhost:3000/api/health
```

Должен вернуть:
```json
{"status":"OK","timestamp":"2024-01-15T10:30:00.000Z"}
```

### 2. Проверить товары

```bash
curl http://localhost:3000/api/products
```

### 3. Проверить чат

```bash
curl -X POST http://localhost:3000/api/gemini/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"Привет!"}'
```

### 4. Открыть сайт

Открыть в браузере: http://localhost:3000

---

## Остановка сервера

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

---

## Полезные команды

### Просмотреть логи PostgreSQL

```bash
docker-compose logs -f postgres
```

### Перезапустить PostgreSQL

```bash
docker-compose restart postgres
```

### Удалить данные БД

```bash
docker-compose down -v
```

### Проверить статус контейнеров

```bash
docker-compose ps
```

---

## Если что-то не работает

### Backend не запускается

```bash
# Проверить, что Node.js установлен
node --version

# Проверить, что зависимости установлены
cd site/backend && npm install

# Проверить, что порт 3000 свободен
lsof -i :3000  # Linux/macOS
netstat -ano | findstr :3000  # Windows
```

### PostgreSQL не запускается

```bash
# Проверить, что Docker запущен
docker --version

# Проверить логи
docker-compose logs postgres

# Перезапустить
docker-compose restart postgres
```

### Чат не работает

```bash
# Проверить, что GEMINI_API_KEY установлен
cat site/backend/.env | grep GEMINI_API_KEY

# Проверить консоль браузера (F12 → Console)
# Проверить логи backend (npm run dev)
```

### Сайт не загружается

```bash
# Проверить, что backend запущен
curl http://localhost:3000/api/health

# Очистить кэш браузера (Ctrl+Shift+Delete)
# Перезагрузить страницу (Ctrl+R)
```

---

## Структура проекта

```
site/
├── Raihan/              # Frontend (не трогать!)
├── backend/             # Backend сервер
│   ├── server.js       # Главный файл
│   ├── package.json    # Зависимости
│   └── .env            # Переменные окружения
├── docker-compose.yml  # Docker конфигурация
└── README.md           # Полная документация
```

---

## Дальнейшие шаги

1. Прочитать [README.md](./README.md) для полной документации
2. Прочитать [SETUP.md](./SETUP.md) для подробной установки
3. Прочитать [CHAT_WIDGET_INTEGRATION.md](./CHAT_WIDGET_INTEGRATION.md) для интеграции чата
4. Посмотреть примеры в [backend/examples/](./backend/examples/)

---

## Контакты

Для вопросов обратитесь к документации или создайте issue в репозитории.

**Версия**: 1.0.0  
**Статус**: Ready to use ✅
