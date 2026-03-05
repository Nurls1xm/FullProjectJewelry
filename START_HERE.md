# 🎯 НАЧНИТЕ ОТСЮДА

Добро пожаловать в Rai Diamond Store! Этот файл поможет вам быстро начать работу.

## За 5 минут до запуска

### 1️⃣ Проверьте требования

```bash
# Проверить Node.js
node --version  # Должно быть 16+

# Проверить Docker
docker --version
docker-compose --version
```

Если что-то не установлено, смотрите [INSTALL.md](./INSTALL.md)

### 2️⃣ Установите зависимости

```bash
cd site/backend
npm install
cd ..
```

### 3️⃣ Получите Gemini API ключ

1. Перейти на https://makersuite.google.com/app/apikey
2. Нажать "Create API Key"
3. Скопировать ключ

### 4️⃣ Настройте переменные окружения

Отредактировать `site/backend/.env`:

```env
GEMINI_API_KEY=your_key_here
```

Замените `your_key_here` на ваш реальный ключ

### 5️⃣ Запустите проект

```bash
cd site

# Запустить БД
docker-compose up -d

# Запустить backend
cd backend
npm run dev
```

### 6️⃣ Откройте в браузере

http://localhost:3000

**Готово!** 🎉

---

## Что дальше?

### Проверить работу

1. **Сайт загружается?**
   - Открыть http://localhost:3000
   - Должна быть главная страница

2. **Чат-виджет видна?**
   - Посмотреть в правый нижний угол
   - Должна быть кнопка 💬

3. **Чат работает?**
   - Нажать на кнопку чата
   - Написать сообщение
   - Должен прийти ответ

### Если что-то не работает

1. Проверить консоль браузера (F12 → Console)
2. Проверить логи backend (в терминале)
3. Прочитать [FAQ.md](./FAQ.md)
4. Прочитать [INSTALL.md](./INSTALL.md)

---

## Документация

### Быстрый старт
- [QUICK_START.md](./QUICK_START.md) - За 5 минут

### Подробная установка
- [INSTALL.md](./INSTALL.md) - Пошаговая инструкция
- [SETUP.md](./SETUP.md) - Подробная конфигурация

### Использование
- [README.md](./README.md) - Полный обзор
- [FAQ.md](./FAQ.md) - Часто задаваемые вопросы

### Развертывание
- [DEPLOYMENT.md](./DEPLOYMENT.md) - На production

### Архитектура
- [ARCHITECTURE.md](./ARCHITECTURE.md) - Как всё устроено
- [PROJECT_SUMMARY.md](./PROJECT_SUMMARY.md) - Резюме проекта

### Интеграция
- [CHAT_WIDGET_INTEGRATION.md](./CHAT_WIDGET_INTEGRATION.md) - Чат-виджет
- [PAGES_UPDATE.md](./PAGES_UPDATE.md) - Обновление страниц

### Примеры
- [backend/examples/api-examples.md](./backend/examples/api-examples.md) - API примеры
- [backend/examples/database-examples.sql](./backend/examples/database-examples.sql) - SQL примеры

---

## Команды

### Запуск

```bash
# Запустить БД
docker-compose up -d

# Запустить backend
cd site/backend
npm run dev

# Открыть сайт
# http://localhost:3000
```

### Остановка

```bash
# Остановить backend
# Нажать Ctrl+C в терминале

# Остановить БД
docker-compose down
```

### Проверка

```bash
# Проверить API
curl http://localhost:3000/api/health

# Проверить товары
curl http://localhost:3000/api/products

# Проверить чат
curl -X POST http://localhost:3000/api/gemini/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"Привет!"}'
```

---

## Структура проекта

```
site/
├── Raihan/                    # Frontend (HTML, CSS, JS)
│   ├── index.html            # Главная страница
│   ├── catalog.html          # Каталог
│   ├── login.html            # Вход
│   ├── register.html         # Регистрация
│   ├── services.html         # Услуги
│   ├── about.html            # О нас
│   ├── admin-dashboard.html  # Админ панель
│   ├── css/                  # Стили
│   ├── js/
│   │   ├── js.js            # Основной скрипт
│   │   └── chat-widget.js   # Чат-виджет (новый)
│   ├── imgs/                # Изображения
│   └── icons/               # Иконки
├── backend/                  # Backend (Node.js + Express)
│   ├── server.js            # Главный файл
│   ├── package.json         # Зависимости
│   ├── .env                 # Переменные окружения
│   ├── config/              # Конфигурация
│   ├── routes/              # API маршруты
│   ├── controllers/         # Логика
│   ├── middleware/          # Middleware
│   └── examples/            # Примеры
├── docker-compose.yml       # Docker конфигурация
├── .env                     # Переменные окружения
└── README.md                # Полная документация
```

---

## Технологический стек

- **Frontend**: HTML5, CSS3, JavaScript
- **Backend**: Node.js, Express.js
- **БД**: PostgreSQL (в Docker)
- **AI**: Google Gemini API
- **DevOps**: Docker, Docker Compose

---

## Требования

- Node.js 16+
- Docker & Docker Compose
- Gemini API ключ
- 2GB RAM минимум

---

## Поддержка

### Документация
- [README.md](./README.md) - Полный обзор
- [FAQ.md](./FAQ.md) - Часто задаваемые вопросы

### Примеры
- [backend/examples/api-examples.md](./backend/examples/api-examples.md)
- [backend/examples/database-examples.sql](./backend/examples/database-examples.sql)

### Внешние ресурсы
- Express: https://expressjs.com/
- PostgreSQL: https://www.postgresql.org/
- Gemini API: https://ai.google.dev/
- Docker: https://docs.docker.com/

---

## Чек-лист первого запуска

- [ ] Node.js установлен
- [ ] Docker установлен
- [ ] Зависимости установлены
- [ ] Gemini API ключ получен
- [ ] .env файл настроен
- [ ] БД запущена
- [ ] Backend запущен
- [ ] Сайт открывается
- [ ] Чат-виджет видна
- [ ] Чат работает

---

## Следующие шаги

1. **Прочитать документацию**
   - [README.md](./README.md) - Полный обзор
   - [QUICK_START.md](./QUICK_START.md) - Быстрый старт

2. **Изучить примеры**
   - [backend/examples/api-examples.md](./backend/examples/api-examples.md)
   - [backend/examples/database-examples.sql](./backend/examples/database-examples.sql)

3. **Развернуть на production**
   - [DEPLOYMENT.md](./DEPLOYMENT.md)

4. **Интегрировать дополнительные функции**
   - Платежная система
   - Email уведомления
   - Аналитика

---

## Проблемы?

1. Проверить [FAQ.md](./FAQ.md)
2. Проверить логи
3. Прочитать [INSTALL.md](./INSTALL.md)
4. Создать issue в репозитории

---

**Версия**: 1.0.0  
**Статус**: Ready to use ✅

**Удачи!** 🚀
