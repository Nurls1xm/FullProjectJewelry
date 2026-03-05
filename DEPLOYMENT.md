# 🚀 Развертывание на Production

Руководство по развертыванию Rai Diamond Store на production сервере.

## Требования

- Ubuntu 20.04 LTS
- 2GB RAM минимум
- 10GB свободного места
- Доменное имя (опционально)
- SSL сертификат (рекомендуется)

## Шаг 1: Подготовка сервера

### Обновить систему

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

### Установить Node.js

```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
node --version
npm --version
```

### Установить Docker

```bash
sudo apt-get install -y docker.io docker-compose
sudo usermod -aG docker $USER
newgrp docker
docker --version
```

### Установить Nginx

```bash
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
```

### Установить Git (опционально)

```bash
sudo apt-get install -y git
```

---

## Шаг 2: Развернуть приложение

### Клонировать репозиторий

```bash
cd /var/www
sudo git clone https://github.com/your-repo/rai-diamond-store.git
cd rai-diamond-store/site
```

Или скопировать файлы вручную:

```bash
cd /var/www
sudo mkdir -p rai-diamond-store
sudo cp -r /path/to/local/site/* rai-diamond-store/
cd rai-diamond-store
```

### Установить зависимости

```bash
cd backend
npm install --production
cd ..
```

### Настроить переменные окружения

```bash
cd backend
sudo nano .env
```

Содержимое `.env`:

```env
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=your_secure_password_here
DB_NAME=bijouterie
PORT=3000
NODE_ENV=production
GEMINI_API_KEY=your_gemini_api_key_here
```

Сохранить: `Ctrl+X` → `Y` → `Enter`

---

## Шаг 3: Запустить PostgreSQL

### Обновить docker-compose.yml

```bash
cd /var/www/rai-diamond-store/site
sudo nano docker-compose.yml
```

Обновить пароль:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:13-alpine
    container_name: bijouterie_db
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: your_secure_password_here
      POSTGRES_DB: bijouterie
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
```

### Запустить контейнер

```bash
docker-compose up -d
docker-compose logs postgres
```

---

## Шаг 4: Запустить Backend с PM2

### Установить PM2 глобально

```bash
sudo npm install -g pm2
```

### Создать PM2 конфиг

```bash
cd /var/www/rai-diamond-store/site/backend
sudo nano ecosystem.config.js
```

Содержимое:

```javascript
module.exports = {
  apps: [{
    name: 'rai-diamond-api',
    script: './server.js',
    instances: 'max',
    exec_mode: 'cluster',
    env: {
      NODE_ENV: 'production',
      PORT: 3000
    },
    error_file: './logs/error.log',
    out_file: './logs/out.log',
    log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
    merge_logs: true,
    autorestart: true,
    watch: false,
    max_memory_restart: '500M'
  }]
};
```

### Запустить приложение

```bash
pm2 start ecosystem.config.js
pm2 save
pm2 startup
```

### Проверить статус

```bash
pm2 status
pm2 logs rai-diamond-api
```

---

## Шаг 5: Настроить Nginx

### Создать конфиг Nginx

```bash
sudo nano /etc/nginx/sites-available/rai-diamond
```

Содержимое (без SSL):

```nginx
server {
    listen 80;
    server_name your-domain.com www.your-domain.com;

    client_max_body_size 50M;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }

    # Кэширование статических файлов
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

### Активировать конфиг

```bash
sudo ln -s /etc/nginx/sites-available/rai-diamond /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx
```

---

## Шаг 6: Настроить SSL (Let's Encrypt)

### Установить Certbot

```bash
sudo apt-get install -y certbot python3-certbot-nginx
```

### Получить сертификат

```bash
sudo certbot --nginx -d your-domain.com -d www.your-domain.com
```

### Автоматическое обновление

```bash
sudo systemctl enable certbot.timer
sudo systemctl start certbot.timer
```

### Проверить конфиг Nginx

```bash
sudo nginx -t
sudo systemctl restart nginx
```

---

## Шаг 7: Настроить Firewall

### Включить UFW

```bash
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

### Разрешить необходимые порты

```bash
sudo ufw allow 22/tcp    # SSH
sudo ufw allow 80/tcp    # HTTP
sudo ufw allow 443/tcp   # HTTPS
sudo ufw allow 5432/tcp  # PostgreSQL (только локально)
```

### Проверить статус

```bash
sudo ufw status
```

---

## Мониторинг и Логирование

### Просмотреть логи приложения

```bash
pm2 logs rai-diamond-api
```

### Просмотреть логи Nginx

```bash
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### Просмотреть логи PostgreSQL

```bash
docker-compose logs -f postgres
```

### Настроить ротацию логов

```bash
sudo nano /etc/logrotate.d/rai-diamond
```

Содержимое:

```
/var/www/rai-diamond-store/site/backend/logs/*.log {
    daily
    rotate 14
    compress
    delaycompress
    notifempty
    create 0640 nobody nobody
    sharedscripts
}
```

---

## Резервное копирование

### Резервная копия БД

```bash
#!/bin/bash
BACKUP_DIR="/var/backups/rai-diamond"
mkdir -p $BACKUP_DIR

docker-compose exec -T postgres pg_dump -U postgres bijouterie | \
  gzip > $BACKUP_DIR/bijouterie_$(date +%Y%m%d_%H%M%S).sql.gz

# Удалить старые резервные копии (старше 30 дней)
find $BACKUP_DIR -name "*.sql.gz" -mtime +30 -delete
```

### Автоматическое резервное копирование (Cron)

```bash
sudo crontab -e
```

Добавить:

```cron
# Резервная копия БД каждый день в 2:00 AM
0 2 * * * /var/www/rai-diamond-store/backup.sh
```

---

## Обновление приложения

### Обновить код

```bash
cd /var/www/rai-diamond-store/site
sudo git pull origin main
```

### Обновить зависимости

```bash
cd backend
npm install --production
```

### Перезапустить приложение

```bash
pm2 restart rai-diamond-api
```

### Проверить статус

```bash
pm2 status
curl https://your-domain.com/api/health
```

---

## Решение проблем

### Приложение не запускается

```bash
# Проверить логи
pm2 logs rai-diamond-api

# Проверить синтаксис
node -c backend/server.js

# Перезапустить
pm2 restart rai-diamond-api
```

### PostgreSQL не подключается

```bash
# Проверить статус контейнера
docker-compose ps

# Проверить логи
docker-compose logs postgres

# Перезапустить
docker-compose restart postgres
```

### Nginx не работает

```bash
# Проверить конфиг
sudo nginx -t

# Просмотреть логи
sudo tail -f /var/log/nginx/error.log

# Перезапустить
sudo systemctl restart nginx
```

### Высокое использование памяти

```bash
# Проверить процессы
pm2 monit

# Перезапустить приложение
pm2 restart rai-diamond-api

# Увеличить лимит памяти в ecosystem.config.js
max_memory_restart: '1G'
```

---

## Производительность

### Включить gzip сжатие

```bash
sudo nano /etc/nginx/nginx.conf
```

Добавить в блок `http`:

```nginx
gzip on;
gzip_vary on;
gzip_min_length 1000;
gzip_types text/plain text/css text/xml text/javascript 
           application/x-javascript application/xml+rss 
           application/json application/javascript;
```

### Оптимизировать PostgreSQL

```bash
docker-compose exec postgres psql -U postgres -d bijouterie -c "VACUUM ANALYZE;"
```

### Мониторить производительность

```bash
# Использование CPU и памяти
top

# Использование диска
df -h

# Использование сети
nethogs
```

---

## Безопасность

### Обновлять систему регулярно

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

### Настроить SSH ключи

```bash
# На локальной машине
ssh-keygen -t rsa -b 4096

# На сервере
mkdir -p ~/.ssh
cat >> ~/.ssh/authorized_keys < your_public_key.pub
chmod 600 ~/.ssh/authorized_keys
```

### Отключить пароль SSH

```bash
sudo nano /etc/ssh/sshd_config
```

Найти и изменить:

```
PasswordAuthentication no
PubkeyAuthentication yes
```

Перезапустить SSH:

```bash
sudo systemctl restart ssh
```

### Настроить fail2ban

```bash
sudo apt-get install -y fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

---

## Мониторинг здоровья

### Создать скрипт проверки

```bash
#!/bin/bash

# Проверить API
curl -s http://localhost:3000/api/health || echo "API DOWN"

# Проверить БД
docker-compose exec -T postgres pg_isready -U postgres || echo "DB DOWN"

# Проверить Nginx
curl -s http://localhost || echo "NGINX DOWN"
```

### Настроить мониторинг (опционально)

Использовать сервисы:
- Uptime Robot (https://uptimerobot.com/)
- Pingdom (https://www.pingdom.com/)
- New Relic (https://newrelic.com/)

---

## Чек-лист развертывания

- [ ] Сервер подготовлен (Node.js, Docker, Nginx)
- [ ] Приложение развернуто
- [ ] Переменные окружения настроены
- [ ] PostgreSQL запущен
- [ ] Backend запущен с PM2
- [ ] Nginx настроен
- [ ] SSL сертификат установлен
- [ ] Firewall настроен
- [ ] Резервное копирование настроено
- [ ] Мониторинг настроен
- [ ] Тестирование завершено

---

## Поддержка

Для вопросов обратитесь к документации:
- Ubuntu: https://ubuntu.com/
- Node.js: https://nodejs.org/
- Docker: https://docs.docker.com/
- Nginx: https://nginx.org/
- PM2: https://pm2.keymetrics.io/

---

**Версия**: 1.0.0  
**Последнее обновление**: 2024-01-15  
**Статус**: Production Ready ✅
