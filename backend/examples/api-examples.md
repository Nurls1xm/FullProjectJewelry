# API Examples - Rai Diamond Store

## Базовые примеры запросов

### 1. Health Check

```bash
curl http://localhost:3000/api/health
```

**Ответ:**
```json
{
  "status": "OK",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

---

## Товары (Products)

### Получить все товары

```bash
curl http://localhost:3000/api/products
```

**Ответ:**
```json
[
  {
    "id": 1,
    "name": "Золотое кольцо",
    "description": "Красивое золотое кольцо с бриллиантом",
    "price": 750000,
    "category": "rings",
    "image_url": "/imgs/ring.jpg",
    "created_at": "2024-01-15T10:00:00.000Z"
  },
  {
    "id": 2,
    "name": "Серебряные серьги",
    "description": "Элегантные серебряные серьги",
    "price": 250000,
    "category": "earrings",
    "image_url": "/imgs/earrings.jpg",
    "created_at": "2024-01-15T10:00:00.000Z"
  }
]
```

### Получить товар по ID

```bash
curl http://localhost:3000/api/products/1
```

**Ответ:**
```json
{
  "id": 1,
  "name": "Золотое кольцо",
  "description": "Красивое золотое кольцо с бриллиантом",
  "price": 750000,
  "category": "rings",
  "image_url": "/imgs/ring.jpg",
  "created_at": "2024-01-15T10:00:00.000Z"
}
```

### Поиск товаров

```bash
curl "http://localhost:3000/api/search?query=кольцо"
```

**Ответ:**
```json
[
  {
    "id": 1,
    "name": "Золотое кольцо",
    "description": "Красивое золотое кольцо с бриллиантом",
    "price": 750000,
    "category": "rings",
    "image_url": "/imgs/ring.jpg"
  }
]
```

---

## Чат с AI (Gemini)

### Отправить сообщение

```bash
curl -X POST http://localhost:3000/api/gemini/chat \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Какие украшения у вас есть?"
  }'
```

**Ответ:**
```json
{
  "message": "Какие украшения у вас есть?",
  "response": "Добро пожаловать в Rai Diamond Store! У нас есть широкий выбор украшений: кольца, серьги, браслеты, ожерелья и многое другое. Все изделия изготовлены из высокачественных материалов. Чем я могу вам помочь?",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

### Примеры вопросов для AI

```bash
# Вопрос о товарах
curl -X POST http://localhost:3000/api/gemini/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "Какое кольцо вы рекомендуете для помолвки?"}'

# Вопрос о цене
curl -X POST http://localhost:3000/api/gemini/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "Какой бюджет нужен для хорошего украшения?"}'

# Вопрос о доставке
curl -X POST http://localhost:3000/api/gemini/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "Как долго доставляется заказ?"}'

# Вопрос на казахском
curl -X POST http://localhost:3000/api/gemini/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "Сіздің ең сұлу сақинасы қайсысы?"}'
```

---

## JavaScript примеры

### Получить товары (Fetch API)

```javascript
// Получить все товары
fetch('/api/products')
  .then(response => response.json())
  .then(products => console.log(products))
  .catch(error => console.error('Error:', error));

// Получить товар по ID
fetch('/api/products/1')
  .then(response => response.json())
  .then(product => console.log(product))
  .catch(error => console.error('Error:', error));

// Поиск товаров
const searchQuery = 'кольцо';
fetch(`/api/search?query=${encodeURIComponent(searchQuery)}`)
  .then(response => response.json())
  .then(results => console.log(results))
  .catch(error => console.error('Error:', error));
```

### Отправить сообщение в чат (Fetch API)

```javascript
async function sendChatMessage(message) {
  try {
    const response = await fetch('/api/gemini/chat', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ message }),
    });

    if (!response.ok) {
      throw new Error('Failed to send message');
    }

    const data = await response.json();
    console.log('AI Response:', data.response);
    return data.response;
  } catch (error) {
    console.error('Chat error:', error);
  }
}

// Использование
sendChatMessage('Какие украшения вы рекомендуете?');
```

### Использование Axios

```javascript
// Установить: npm install axios

const axios = require('axios');

// Получить товары
axios.get('/api/products')
  .then(response => console.log(response.data))
  .catch(error => console.error('Error:', error));

// Отправить сообщение в чат
axios.post('/api/gemini/chat', {
  message: 'Какие украшения у вас есть?'
})
  .then(response => console.log(response.data.response))
  .catch(error => console.error('Error:', error));
```

---

## cURL примеры

### Получить товары с форматированием

```bash
curl -s http://localhost:3000/api/products | jq '.'
```

### Отправить сообщение и сохранить ответ

```bash
curl -X POST http://localhost:3000/api/gemini/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"Привет!"}' \
  -o response.json

cat response.json | jq '.response'
```

### Проверить статус API

```bash
curl -i http://localhost:3000/api/health
```

### Сохранить результаты в файл

```bash
curl http://localhost:3000/api/products > products.json
```

---

## Обработка ошибок

### Пример обработки ошибок в JavaScript

```javascript
async function fetchProducts() {
  try {
    const response = await fetch('/api/products');
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching products:', error);
    // Показать сообщение об ошибке пользователю
    alert('Ошибка при загрузке товаров. Пожалуйста, попробуйте позже.');
  }
}
```

---

## Тестирование API

### Используя Postman

1. Открыть Postman
2. Создать новый запрос
3. Выбрать метод: GET/POST
4. Ввести URL: `http://localhost:3000/api/products`
5. Нажать "Send"

### Используя VS Code REST Client

Создать файл `test.http`:

```http
### Получить все товары
GET http://localhost:3000/api/products

### Получить товар по ID
GET http://localhost:3000/api/products/1

### Поиск товаров
GET http://localhost:3000/api/search?query=кольцо

### Отправить сообщение в чат
POST http://localhost:3000/api/gemini/chat
Content-Type: application/json

{
  "message": "Какие украшения у вас есть?"
}
```

Затем нажать "Send Request" над каждым запросом.

---

## Интеграция с фронтенд

### Пример интеграции в HTML

```html
<!DOCTYPE html>
<html>
<head>
  <title>Товары</title>
</head>
<body>
  <div id="products"></div>

  <script>
    async function loadProducts() {
      try {
        const response = await fetch('/api/products');
        const products = await response.json();
        
        const html = products.map(p => `
          <div>
            <h3>${p.name}</h3>
            <p>${p.description}</p>
            <p>Цена: ${p.price} ₸</p>
          </div>
        `).join('');
        
        document.getElementById('products').innerHTML = html;
      } catch (error) {
        console.error('Error:', error);
      }
    }

    loadProducts();
  </script>
</body>
</html>
```

---

## Лимиты и ограничения

- Максимум 50 товаров в одном запросе
- Максимум 1000 символов в сообщении чата
- Лимиты Gemini API зависят от вашего плана

---

## Поддержка

Для вопросов обратитесь к документации:
- Express: https://expressjs.com/
- Fetch API: https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API
- Gemini API: https://ai.google.dev/
