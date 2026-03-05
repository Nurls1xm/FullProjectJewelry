# Обновление HTML страниц для добавления чат-виджета

## Обзор

Чат-виджет уже добавлен на `index.html`. Чтобы добавить его на другие страницы, нужно добавить одну строку в каждый файл.

## Какие страницы нужно обновить

- [ ] `catalog.html` - Каталог товаров
- [ ] `login.html` - Страница входа
- [ ] `register.html` - Страница регистрации
- [ ] `services.html` - Услуги
- [ ] `about.html` - О нас
- [ ] `admin-dashboard.html` - Админ панель

## Как обновить страницу

### Шаг 1: Открыть HTML файл

Например, `catalog.html`

### Шаг 2: Найти закрывающий тег `</head>`

```html
</head>
```

### Шаг 3: Добавить перед `</head>` эту строку

```html
<script src="./js/chat-widget.js" defer></script>
```

### Шаг 4: Сохранить файл

---

## Примеры для каждой страницы

### catalog.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Каталог - Rai Diamond Store</title>
    <link rel="stylesheet" href="css/catalog.css">
    <script src="./js/chat-widget.js" defer></script>  <!-- ДОБАВИТЬ ЭТУ СТРОКУ -->
</head>
<body>
    <!-- Содержимое страницы -->
</body>
</html>
```

### login.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Вход - Rai Diamond Store</title>
    <link rel="stylesheet" href="css/login.css">
    <script src="./js/chat-widget.js" defer></script>  <!-- ДОБАВИТЬ ЭТУ СТРОКУ -->
</head>
<body>
    <!-- Содержимое страницы -->
</body>
</html>
```

### register.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Регистрация - Rai Diamond Store</title>
    <link rel="stylesheet" href="css/register.css">
    <script src="./js/chat-widget.js" defer></script>  <!-- ДОБАВИТЬ ЭТУ СТРОКУ -->
</head>
<body>
    <!-- Содержимое страницы -->
</body>
</html>
```

### services.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Услуги - Rai Diamond Store</title>
    <link rel="stylesheet" href="css/services.css">
    <script src="./js/chat-widget.js" defer></script>  <!-- ДОБАВИТЬ ЭТУ СТРОКУ -->
</head>
<body>
    <!-- Содержимое страницы -->
</body>
</html>
```

### about.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>О нас - Rai Diamond Store</title>
    <link rel="stylesheet" href="css/about.css">
    <script src="./js/chat-widget.js" defer></script>  <!-- ДОБАВИТЬ ЭТУ СТРОКУ -->
</head>
<body>
    <!-- Содержимое страницы -->
</body>
</html>
```

### admin-dashboard.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Админ панель - Rai Diamond Store</title>
    <link rel="stylesheet" href="css/dashboard.css">
    <script src="./js/chat-widget.js" defer></script>  <!-- ДОБАВИТЬ ЭТУ СТРОКУ -->
</head>
<body>
    <!-- Содержимое страницы -->
</body>
</html>
```

---

## Проверка

После обновления каждой страницы:

1. Открыть страницу в браузере
2. Проверить, что кнопка чата (💬) видна в правом нижнем углу
3. Нажать на кнопку и проверить, что чат открывается
4. Отправить тестовое сообщение

---

## Автоматизация (опционально)

Если нужно обновить все страницы сразу, можно использовать скрипт:

### Linux/macOS

```bash
#!/bin/bash

# Добавить чат-виджет на все HTML страницы
for file in site/Raihan/*.html; do
  if [ "$file" != "site/Raihan/index.html" ]; then
    # Проверить, что строка не добавлена
    if ! grep -q "chat-widget.js" "$file"; then
      # Добавить перед </head>
      sed -i 's|</head>|    <script src="./js/chat-widget.js" defer></script>\n</head>|' "$file"
      echo "✓ Обновлен: $file"
    fi
  fi
done

echo "✓ Все страницы обновлены!"
```

### Windows (PowerShell)

```powershell
# Добавить чат-виджет на все HTML страницы
Get-ChildItem "site/Raihan/*.html" | ForEach-Object {
  if ($_.Name -ne "index.html") {
    $content = Get-Content $_.FullName
    if ($content -notmatch "chat-widget.js") {
      $content = $content -replace "</head>", '    <script src="./js/chat-widget.js" defer></script>' + "`n</head>"
      Set-Content $_.FullName $content
      Write-Host "✓ Обновлен: $($_.Name)"
    }
  }
}

Write-Host "✓ Все страницы обновлены!"
```

---

## Проверка всех страниц

После обновления всех страниц, проверить каждую:

```bash
# Linux/macOS
for file in site/Raihan/*.html; do
  if grep -q "chat-widget.js" "$file"; then
    echo "✓ $file - OK"
  else
    echo "✗ $file - НУЖНО ОБНОВИТЬ"
  fi
done
```

---

## Если что-то пошло не так

### Восстановить оригинальный файл

Если случайно испортили файл, можно восстановить из Git:

```bash
git checkout site/Raihan/catalog.html
```

### Проверить синтаксис HTML

```bash
# Используя онлайн валидатор
# https://validator.w3.org/

# Или локально (если установлен html5validator)
html5validator site/Raihan/catalog.html
```

---

## Статус обновления

Используйте эту таблицу для отслеживания:

| Страница | Статус | Дата |
|----------|--------|------|
| index.html | ✅ Готово | 2024-01-15 |
| catalog.html | ⏳ Ожидает | - |
| login.html | ⏳ Ожидает | - |
| register.html | ⏳ Ожидает | - |
| services.html | ⏳ Ожидает | - |
| about.html | ⏳ Ожидает | - |
| admin-dashboard.html | ⏳ Ожидает | - |

---

## Поддержка

Если возникли проблемы:

1. Проверить консоль браузера (F12 → Console)
2. Проверить, что файл `js/chat-widget.js` существует
3. Проверить, что backend запущен
4. Прочитать [CHAT_WIDGET_INTEGRATION.md](./CHAT_WIDGET_INTEGRATION.md)

---

**Версия**: 1.0.0  
**Последнее обновление**: 2024-01-15
