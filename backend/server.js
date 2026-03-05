const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const path = require('path');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Раздача статических файлов из папки Raihan
app.use(express.static(path.join(__dirname, '../Raihan')));

// API Routes
app.use('/api', require('./routes/api'));
app.use('/api/gemini', require('./routes/gemini'));

// Главная страница (для SPA)
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../Raihan/index.html'));
});

// Обработка всех остальных маршрутов (для навигации SPA)
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../Raihan/index.html'));
});

// Error Handler
app.use(require('./middleware/errorHandler'));

// Запуск сервера
app.listen(PORT, () => {
  console.log(`✓ Backend server running on http://localhost:${PORT}`);
  console.log(`✓ Frontend available at http://localhost:${PORT}`);
  console.log(`✓ API available at http://localhost:${PORT}/api`);
});
