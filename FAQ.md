# ❓ Часто задаваемые вопросы (FAQ)

## Установка и запуск

### Q: Как быстро запустить проект?
**A:** Следуйте [QUICK_START.md](./QUICK_START.md) - это займет 5 минут.

### Q: Какие требования для запуска?
**A:** 
- Node.js 16+
- Docker & Docker Compose
- 2GB RAM минимум
- Gemini API ключ

### Q: Как получить Gemini API ключ?
**A:** 
1. Перейти на https://makersuite.google.com/app/apikey
2. Нажать "Create API Key"
3. Скопировать ключ в `.env` файл

### Q: Можно ли запустить без Docker?
**A:** Да, если у вас установлен PostgreSQL локально. Просто измените `DB_HOST` в `.env` на `localhost`.

### Q: Как изменить порт сервера?
**A:** Отредактировать `backend/.env`:
```env
PORT=3001  # Вместо 3000
```

### Q: Как изменить пароль БД?
**A:** Отредактировать `docker-compose.yml` и `backend/.env`:
```yaml
POSTGRES_PASSWORD: your_new_password
```

---

## Frontend

### Q: Можно ли изменять HTML/CSS/JS сайта?
**A:** Да, вы можете изменять файлы в папке `Raihan/`, но это не требуется для работы backend и чата.

### Q: Как добавить чат-виджет на другие страницы?
**A:** Добавить в `<head>` каждой страницы:
```html
<script src="./js/chat-widget.js" defer></script>
```

Подробнее в [PAGES_UPDATE.md](./PAGES_UPDATE.md)

### Q: Как изменить цвет чат-виджета?
**A:** Отредактировать `css/chat-widget.css`:
```css
.chat-widget-button {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  /* Измените цвет */
}
```

### Q: Как переместить чат-виджет в другое место?
**A:** Отредактировать `css/chat-widget.css`:
```css
.chat-widget-container {
  bottom: 20px;  /* Расстояние от низа */
  right: 20px;   /* Расстояние от права */
  /* Или используйте left вместо right */
}
```

### Q: Почему чат-виджет не появляется?
**A:** 
1. Проверить, что `<script src="./js/chat-widget.js" defer></script>` добавлен
2. Проверить консоль браузера (F12 → Console)
3. Очистить кэш браузера (Ctrl+Shift+Delete)
4. Проверить, что backend запущен

---

## Backend и API

### Q: Как проверить, что backend запущен?
**A:** 
```bash
curl http://localhost:3000/api/health
```

Должен вернуть:
```json
{"status":"OK","timestamp":"..."}
```

### Q: Как получить список товаров?
**A:** 
```bash
curl http://localhost:3000/api/products
```

### Q: Как искать товары?
**A:** 
```bash
curl "http://localhost:3000/api/search?query=кольцо"
```

### Q: Как добавить новый API endpoint?
**A:** 
1. Создать функцию в `backend/controllers/`
2. Добавить маршрут в `backend/routes/api.js`
3. Перезапустить backend

Пример:
```javascript
// controllers/productController.js
exports.getCategories = async (req, res) => {
  const result = await pool.query('SELECT DISTINCT category FROM products');
  res.json(result.rows);
};

// routes/api.js
router.get('/categories', productController.getCategories);
```

### Q: Как добавить аутентификацию?
**A:** Это требует дополнительной работы. Нужно:
1. Добавить JWT токены
2. Создать middleware для проверки токенов
3. Защитить API endpoints

Рекомендуется использовать `jsonwebtoken` пакет.

### Q: Как обработать ошибки API?
**A:** Все ошибки обрабатываются middleware `errorHandler.js`. Для кастомных ошибок:
```javascript
res.status(400).json({ error: 'Custom error message' });
```

---

## База данных

### Q: Как подключиться к БД напрямую?
**A:** 
```bash
# Используя psql
psql -h localhost -U postgres -d bijouterie

# Или используя Docker
docker-compose exec postgres psql -U postgres -d bijouterie
```

### Q: Как выполнить SQL запрос?
**A:** 
```bash
docker-compose exec postgres psql -U postgres -d bijouterie -c "SELECT * FROM products;"
```

### Q: Как создать резервную копию БД?
**A:** 
```bash
docker-compose exec postgres pg_dump -U postgres bijouterie > backup.sql
```

### Q: Как восстановить БД из резервной копии?
**A:** 
```bash
docker-compose exec -T postgres psql -U postgres bijouterie < backup.sql
```

### Q: Как добавить новую таблицу?
**A:** 
```bash
docker-compose exec postgres psql -U postgres -d bijouterie -c "CREATE TABLE my_table (id SERIAL PRIMARY KEY, name VARCHAR(255));"
```

### Q: Как удалить все данные из таблицы?
**A:** 
```bash
docker-compose exec postgres psql -U postgres -d bijouterie -c "TRUNCATE products;"
```

---

## Чат и Gemini API

### Q: Почему чат не работает?
**A:** 
1. Проверить, что GEMINI_API_KEY установлен в `.env`
2. Проверить, что ключ активен на https://makersuite.google.com/app/apikey
3. Проверить логи backend: `npm run dev`
4. Проверить консоль браузера (F12 → Console)

### Q: Как изменить поведение AI ассистента?
**A:** Отредактировать `backend/controllers/chatController.js`:
```javascript
const systemPrompt = `Ты - вежливый помощник магазина украшений "Rai Diamond Store". 
Помогай клиентам с информацией о товарах, ценах и услугах.
Отвечай на казахском, русском или английском языке в зависимости от языка вопроса.
Будь дружелюбным и профессиональным.`;
```

### Q: Какой язык поддерживает Gemini?
**A:** Gemini поддерживает 100+ языков, включая:
- Русский
- Казахский
- Английский
- Китайский
- Испанский
- И многие другие

### Q: Есть ли лимиты на использование Gemini API?
**A:** Да, зависит от вашего плана. Проверить на https://makersuite.google.com/

### Q: Как добавить контекст в чат?
**A:** Можно передавать информацию о товарах в системный промпт:
```javascript
const systemPrompt = `Ты - помощник магазина. Вот доступные товары: ${productList}`;
```

---

## Развертывание

### Q: Как развернуть на production?
**A:** Следуйте [DEPLOYMENT.md](./DEPLOYMENT.md)

### Q: Какой хостинг рекомендуется?
**A:** 
- DigitalOcean
- Linode
- AWS EC2
- Hetzner
- Любой VPS с Ubuntu 20.04

### Q: Как настроить SSL сертификат?
**A:** Используйте Let's Encrypt с Certbot:
```bash
sudo certbot --nginx -d your-domain.com
```

### Q: Как обновить приложение на production?
**A:** 
```bash
cd /var/www/rai-diamond-store/site
git pull origin main
cd backend && npm install
pm2 restart rai-diamond-api
```

### Q: Как настроить автоматическое резервное копирование?
**A:** Добавить в crontab:
```bash
0 2 * * * docker-compose exec -T postgres pg_dump -U postgres bijouterie | gzip > /var/backups/bijouterie_$(date +\%Y\%m\%d).sql.gz
```

---

## Производительность

### Q: Как улучшить производительность?
**A:** 
1. Добавить индексы в БД
2. Включить кэширование
3. Оптимизировать SQL запросы
4. Использовать CDN для статических файлов
5. Включить gzip сжатие

### Q: Как мониторить производительность?
**A:** 
```bash
# Использование CPU и памяти
top

# Использование диска
df -h

# Логи приложения
pm2 logs rai-diamond-api
```

### Q: Почему приложение медленное?
**A:** 
1. Проверить использование CPU/памяти: `top`
2. Проверить логи: `npm run dev`
3. Проверить SQL запросы
4. Проверить сетевые запросы (F12 → Network)

---

## Безопасность

### Q: Как защитить API?
**A:** 
1. Использовать HTTPS
2. Добавить аутентификацию (JWT)
3. Добавить rate limiting
4. Валидировать входные данные
5. Использовать CORS правильно

### Q: Как защитить БД?
**A:** 
1. Использовать сильный пароль
2. Ограничить доступ (firewall)
3. Регулярно обновлять PostgreSQL
4. Делать резервные копии
5. Использовать SSL для подключения

### Q: Как защитить Gemini API ключ?
**A:** 
1. Никогда не коммитить `.env` в Git
2. Использовать `.gitignore`
3. Хранить ключ только на сервере
4. Регулярно ротировать ключи

### Q: Как защитить от XSS атак?
**A:** 
1. Использовать `textContent` вместо `innerHTML`
2. Экранировать пользовательский ввод
3. Использовать Content Security Policy (CSP)

---

## Отладка

### Q: Как включить debug режим?
**A:** 
```bash
DEBUG=* npm run dev
```

### Q: Как просмотреть логи?
**A:** 
```bash
# Backend логи
npm run dev

# Docker логи
docker-compose logs -f

# PM2 логи (production)
pm2 logs rai-diamond-api
```

### Q: Как найти ошибку в коде?
**A:** 
1. Проверить консоль браузера (F12 → Console)
2. Проверить логи backend
3. Проверить логи Docker
4. Использовать debugger в VS Code

### Q: Как использовать debugger в VS Code?
**A:** Создать `.vscode/launch.json`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Program",
      "program": "${workspaceFolder}/site/backend/server.js"
    }
  ]
}
```

---

## Интеграция

### Q: Как интегрировать платежную систему?
**A:** Нужно:
1. Выбрать платежный провайдер (Stripe, PayPal, etc.)
2. Установить SDK
3. Создать endpoint для обработки платежей
4. Обновить БД

### Q: Как добавить email уведомления?
**A:** Использовать `nodemailer`:
```bash
npm install nodemailer
```

### Q: Как добавить SMS уведомления?
**A:** Использовать Twilio или другой SMS провайдер

### Q: Как интегрировать с другим API?
**A:** 
1. Установить SDK или использовать fetch
2. Создать функцию в controller
3. Добавить маршрут
4. Обработать ошибки

---

## Поддержка

### Q: Где найти документацию?
**A:** 
- [README.md](./README.md) - Обзор
- [SETUP.md](./SETUP.md) - Установка
- [QUICK_START.md](./QUICK_START.md) - Быстрый старт
- [DEPLOYMENT.md](./DEPLOYMENT.md) - Развертывание
- [ARCHITECTURE.md](./ARCHITECTURE.md) - Архитектура
- [CHAT_WIDGET_INTEGRATION.md](./CHAT_WIDGET_INTEGRATION.md) - Чат-виджет

### Q: Где найти примеры?
**A:** 
- [backend/examples/api-examples.md](./backend/examples/api-examples.md)
- [backend/examples/database-examples.sql](./backend/examples/database-examples.sql)

### Q: Как получить помощь?
**A:** 
1. Проверить FAQ (этот документ)
2. Прочитать документацию
3. Проверить логи
4. Создать issue в репозитории

### Q: Как сообщить об ошибке?
**A:** 
1. Описать проблему
2. Приложить логи
3. Указать версию Node.js, Docker, PostgreSQL
4. Указать операционную систему

---

## Лицензия и авторство

### Q: Какая лицензия у проекта?
**A:** MIT License - свободно используйте и модифицируйте

### Q: Кто автор?
**A:** Rai Diamond Store Team

### Q: Можно ли использовать в коммерческих целях?
**A:** Да, лицензия MIT позволяет это

---

**Версия**: 1.0.0  
**Последнее обновление**: 2024-01-15  
**Статус**: Complete ✅
