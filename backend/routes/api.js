const express = require('express');
const router = express.Router();
const productController = require('../controllers/productController');

// Товары
router.get('/products', productController.getAllProducts);
router.get('/products/:id', productController.getProductById);
router.get('/search', productController.searchProducts);

// Health check
router.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

module.exports = router;
