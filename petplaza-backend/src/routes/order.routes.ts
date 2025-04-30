import express, { RequestHandler } from 'express';
import { 
  createOrder, 
  getUserOrders,
  getProductOrders,
  updateOrderStatus
} from '../controllers/order.controller';
import { protect } from '../middleware/auth.middleware';

const router = express.Router();

// All routes are protected
router.use(protect);

// Create order
router.post('/', createOrder as RequestHandler);

// Get user's orders
router.get('/user', getUserOrders as RequestHandler);

// Get product orders (for adoption centres)
router.get('/product/:productId', getProductOrders as RequestHandler);

// Update order status
router.put('/:id/status', updateOrderStatus as RequestHandler);

export default router; 