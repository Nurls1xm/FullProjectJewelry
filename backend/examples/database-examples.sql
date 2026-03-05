-- Примеры SQL запросов для работы с базой данных bijouterie

-- ============================================
-- ПРИМЕРЫ ЗАПРОСОВ К ТАБЛИЦЕ PRODUCTS
-- ============================================

-- Получить все товары
SELECT * FROM products;

-- Получить товары с ограничением
SELECT * FROM products LIMIT 10;

-- Получить товар по ID
SELECT * FROM products WHERE id = 1;

-- Поиск товаров по названию
SELECT * FROM products WHERE name ILIKE '%кольцо%';

-- Поиск товаров по описанию
SELECT * FROM products WHERE description ILIKE '%золото%';

-- Получить товары в диапазоне цен
SELECT * FROM products WHERE price BETWEEN 100000 AND 500000;

-- Получить товары, отсортированные по цене
SELECT * FROM products ORDER BY price ASC;

-- Получить товары, отсортированные по названию
SELECT * FROM products ORDER BY name ASC;

-- Получить количество товаров
SELECT COUNT(*) as total_products FROM products;

-- Получить среднюю цену товаров
SELECT AVG(price) as average_price FROM products;

-- Получить минимальную и максимальную цену
SELECT MIN(price) as min_price, MAX(price) as max_price FROM products;

-- ============================================
-- ПРИМЕРЫ ЗАПРОСОВ К ТАБЛИЦЕ USERS
-- ============================================

-- Получить всех пользователей
SELECT * FROM users;

-- Получить пользователя по ID
SELECT * FROM users WHERE id = 1;

-- Получить пользователя по email
SELECT * FROM users WHERE email = '[email]';

-- Получить активных пользователей
SELECT * FROM users WHERE is_active = true;

-- ============================================
-- ПРИМЕРЫ ЗАПРОСОВ К ТАБЛИЦЕ ORDERS
-- ============================================

-- Получить все заказы
SELECT * FROM orders;

-- Получить заказы пользователя
SELECT * FROM orders WHERE user_id = 1;

-- Получить заказы за последний месяц
SELECT * FROM orders WHERE created_at >= NOW() - INTERVAL '1 month';

-- Получить сумму всех заказов
SELECT SUM(total_amount) as total_sales FROM orders;

-- ============================================
-- ПРИМЕРЫ ЗАПРОСОВ К ТАБЛИЦЕ ORDER_ITEMS
-- ============================================

-- Получить товары в заказе
SELECT * FROM order_items WHERE order_id = 1;

-- Получить популярные товары (по количеству заказов)
SELECT product_id, COUNT(*) as order_count 
FROM order_items 
GROUP BY product_id 
ORDER BY order_count DESC 
LIMIT 10;

-- ============================================
-- ПРИМЕРЫ ОБЪЕДИНЁННЫХ ЗАПРОСОВ
-- ============================================

-- Получить заказы с информацией о пользователе
SELECT o.id, o.created_at, u.name, u.email, o.total_amount
FROM orders o
JOIN users u ON o.user_id = u.id
ORDER BY o.created_at DESC;

-- Получить товары в заказе с названиями
SELECT oi.order_id, p.name, oi.quantity, oi.price
FROM order_items oi
JOIN products p ON oi.product_id = p.id
WHERE oi.order_id = 1;

-- Получить статистику по заказам пользователя
SELECT 
  u.name,
  COUNT(o.id) as total_orders,
  SUM(o.total_amount) as total_spent,
  AVG(o.total_amount) as average_order
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name
ORDER BY total_spent DESC;

-- ============================================
-- ПРИМЕРЫ ВСТАВКИ ДАННЫХ
-- ============================================

-- Добавить нового пользователя
INSERT INTO users (name, email, password, phone, is_active)
VALUES ('[name]', '[email]', 'hashed_password', '+1234567890', true);

-- Добавить новый товар
INSERT INTO products (name, description, price, category, image_url)
VALUES ('Золотое кольцо', 'Красивое золотое кольцо с бриллиантом', 750000, 'rings', '/imgs/ring.jpg');

-- Добавить новый заказ
INSERT INTO orders (user_id, total_amount, status)
VALUES (1, 1500000, 'pending');

-- Добавить товар в заказ
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (1, 1, 2, 750000);

-- ============================================
-- ПРИМЕРЫ ОБНОВЛЕНИЯ ДАННЫХ
-- ============================================

-- Обновить цену товара
UPDATE products SET price = 800000 WHERE id = 1;

-- Обновить статус заказа
UPDATE orders SET status = 'completed' WHERE id = 1;

-- Обновить информацию пользователя
UPDATE users SET phone = '+9876543210' WHERE id = 1;

-- ============================================
-- ПРИМЕРЫ УДАЛЕНИЯ ДАННЫХ
-- ============================================

-- Удалить товар (осторожно!)
DELETE FROM products WHERE id = 1;

-- Удалить заказ (осторожно!)
DELETE FROM orders WHERE id = 1;

-- ============================================
-- ПОЛЕЗНЫЕ КОМАНДЫ
-- ============================================

-- Показать все таблицы
\dt

-- Показать структуру таблицы
\d products

-- Показать индексы
\di

-- Показать размер БД
SELECT pg_size_pretty(pg_database_size('bijouterie'));

-- Показать размер таблицы
SELECT pg_size_pretty(pg_total_relation_size('products'));
