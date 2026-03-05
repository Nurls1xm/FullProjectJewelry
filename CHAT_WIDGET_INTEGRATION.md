# Интеграция Чат-Виджета AI Ассистента

## Обзор

Чат-виджет AI ассистента уже интегрирован в сайт и использует Google Gemini API для ответов на вопросы пользователей.

## Структура файлов

```
site/Raihan/
├── index.html                 # Главная страница (обновлена)
├── catalog.html               # Каталог (нужно обновить)
├── login.html                 # Логин (нужно обновить)
├── register.html              # Регистрация (нужно обновить)
├── services.html              # Услуги (нужно обновить)
├── about.html                 # О нас (нужно обновить)
├── admin-dashboard.html       # Админ панель (нужно обновить)
├── css/
│   └── chat-widget.css        # Стили виджета (новый файл)
└── js/
    └── chat-widget.js         # Логика виджета (новый файл)
```

## Как добавить виджет на другие страницы

Чтобы добавить чат-виджет на другие HTML страницы, добавьте эту строку в `<head>` каждой страницы:

```html
<script src="./js/chat-widget.js" defer></script>
```

### Пример для catalog.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Каталог - Rai Diamond Store</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="./js/chat-widget.js" defer></script>  <!-- Добавить эту строку -->
</head>
<body>
    <!-- Содержимое страницы -->
</body>
</html>
```

### Пример для login.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Вход - Rai Diamond Store</title>
    <link rel="stylesheet" href="css/login.css">
    <script src="./js/chat-widget.js" defer></script>  <!-- Добавить эту строку -->
</head>
<body>
    <!-- Содержимое страницы -->
</body>
</html>
```

## Как работает виджет

### Инициализация

Виджет автоматически инициализируется при загрузке страницы:

```javascript
// Инициализировать виджет при загрузке страницы
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => {
    new ChatWidget();
  });
} else {
  new ChatWidget();
}
```

### Структура класса ChatWidget

```javascript
class ChatWidget {
  constructor()           // Инициализация
  init()                  // Инициализация компонентов
  loadStyles()            // Загрузка CSS
  createWidget()          // Создание HTML элементов
  attachEventListeners()  // Привязка обработчиков событий
  toggleChat()            // Открыть/закрыть чат
  openChat()              // Открыть чат
  closeChat()             // Закрыть чат
  sendMessage()           // Отправить сообщение
  addMessage()            // Добавить сообщение в чат
  showLoading()           // Показать индикатор загрузки
  removeLoading()         // Убрать индикатор загрузки
}
```

## Внешний вид

### Кнопка чата
- Расположение: правый нижний угол (fixed position)
- Размер: 60x60 пикселей
- Форма: круглая
- Цвет: градиент фиолетовый (667eea → 764ba2)
- Иконка: 💬 (emoji)

### Окно чата
- Размер: 380x500 пикселей (адаптивный на мобильных)
- Расположение: над кнопкой
- Анимация: плавное появление (slideUp)
- Содержит:
  - Заголовок с названием ассистента
  - Область сообщений (прокручиваемая)
  - Поле ввода сообщения
  - Кнопка отправки

## Кастомизация

### Изменить цвет виджета

В файле `css/chat-widget.css` найти и изменить:

```css
/* Изменить цвет кнопки */
.chat-widget-button {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  /* Измените на нужный цвет */
}

/* Изменить цвет заголовка */
.chat-widget-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  /* Измените на нужный цвет */
}

/* Изменить цвет сообщений пользователя */
.chat-message.user .chat-message-content {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  /* Измените на нужный цвет */
}
```

### Изменить размер окна

```css
.chat-widget-window {
  width: 380px;    /* Измените ширину */
  height: 500px;   /* Измените высоту */
}
```

### Изменить позицию

```css
.chat-widget-container {
  bottom: 20px;    /* Расстояние от низа */
  right: 20px;     /* Расстояние от права */
  /* Или используйте left вместо right для левой стороны */
}
```

### Изменить иконку

В файле `js/chat-widget.js` найти:

```javascript
<button class="chat-widget-button" id="chatToggle" title="Чат с ассистентом">
  💬  <!-- Измените эмодзи на нужный -->
</button>
```

### Изменить приветственное сообщение

```javascript
<div class="chat-message bot">
  <div class="chat-message-content">
    Привет! 👋 Я помощник магазина Rai Diamond Store. Чем я могу вам помочь?
    <!-- Измените текст -->
  </div>
</div>
```

## Интеграция с backend

### Endpoint для чата

```
POST /api/gemini/chat
Content-Type: application/json

{
  "message": "Ваше сообщение"
}
```

### Ответ

```json
{
  "message": "Ваше сообщение",
  "response": "Ответ от Gemini AI",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

### Обработка ошибок

Если API недоступен, виджет покажет сообщение об ошибке:

```
"Извините, произошла ошибка. Пожалуйста, попробуйте позже."
```

## Отладка

### Проверить консоль браузера

1. Открыть DevTools (F12)
2. Перейти на вкладку "Console"
3. Проверить наличие ошибок

### Проверить загрузку файлов

1. Открыть DevTools (F12)
2. Перейти на вкладку "Network"
3. Проверить, что загружаются:
   - `/js/chat-widget.js`
   - `/css/chat-widget.css`

### Проверить API запросы

1. Открыть DevTools (F12)
2. Перейти на вкладку "Network"
3. Отправить сообщение в чат
4. Проверить запрос к `/api/gemini/chat`

### Логирование

Добавить логирование в `js/chat-widget.js`:

```javascript
async sendMessage() {
  const input = document.getElementById('chatInput');
  const message = input.value.trim();

  console.log('Sending message:', message);  // Добавить логирование

  // ... остальной код
}
```

## Проблемы и решения

### Виджет не появляется

**Проблема:** Кнопка чата не видна на странице

**Решение:**
1. Проверить, что `<script src="./js/chat-widget.js" defer></script>` добавлен в `<head>`
2. Проверить консоль браузера на ошибки
3. Проверить, что файл `js/chat-widget.js` существует
4. Очистить кэш браузера (Ctrl+Shift+Delete)

### Чат не отправляет сообщения

**Проблема:** При нажатии на кнопку отправки ничего не происходит

**Решение:**
1. Проверить, что backend запущен (`npm run dev`)
2. Проверить, что `/api/gemini/chat` доступен
3. Проверить консоль браузера на ошибки
4. Проверить, что GEMINI_API_KEY установлен в `.env`

### Ошибка "Failed to get response"

**Проблема:** Виджет показывает ошибку при отправке сообщения

**Решение:**
1. Проверить, что backend запущен
2. Проверить логи backend (`npm run dev`)
3. Проверить, что Gemini API ключ корректен
4. Проверить лимиты Gemini API

### Виджет перекрывает контент

**Проблема:** Кнопка чата перекрывает важный контент на странице

**Решение:**
1. Изменить позицию в `css/chat-widget.css`:
   ```css
   .chat-widget-container {
     bottom: 100px;  /* Увеличить расстояние от низа */
     right: 20px;
   }
   ```

## Производительность

### Оптимизация

- Виджет загружается асинхронно (defer)
- CSS загружается динамически при инициализации
- Сообщения кэшируются в памяти
- Нет внешних зависимостей (чистый JavaScript)

### Размер файлов

- `js/chat-widget.js`: ~4 KB
- `css/chat-widget.css`: ~3 KB
- Итого: ~7 KB

## Безопасность

### Защита от XSS

Все сообщения экранируются перед отображением:

```javascript
const contentDiv = document.createElement('div');
contentDiv.className = 'chat-message-content';
contentDiv.textContent = text;  // textContent безопасен от XSS
```

### Защита от CSRF

Используется стандартный CORS для защиты от CSRF атак.

## Поддержка браузеров

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+
- Mobile browsers (iOS Safari, Chrome Mobile)

## Лицензия

MIT License - свободно используйте и модифицируйте

## Поддержка

Для вопросов обратитесь к документации:
- Gemini API: https://ai.google.dev/
- JavaScript: https://developer.mozilla.org/en-US/docs/Web/JavaScript/
