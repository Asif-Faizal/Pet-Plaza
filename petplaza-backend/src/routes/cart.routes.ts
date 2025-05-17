import express, { RequestHandler } from 'express';
import { 
  addToCart, 
  getCart, 
  updateCartItem, 
  removeCartItem, 
  clearCart 
} from '../controllers/cart.controller';
import { protect } from '../middleware/auth.middleware';

const router = express.Router();

// All routes are protected
router.use(protect);

// Add to cart
router.post('/', addToCart as RequestHandler);

// Get user's cart
router.get('/', getCart as RequestHandler);

// Update cart item quantity
router.put('/:productId', updateCartItem as RequestHandler);

// Remove item from cart
router.delete('/:productId', removeCartItem as RequestHandler);

// Clear cart
router.delete('/', clearCart as RequestHandler);

export default router; 