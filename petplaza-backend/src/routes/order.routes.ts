import express, { RequestHandler } from 'express';
import { 
  createOrder, 
  getUserOrders,
  getProductOrders,
  updateOrderStatus,
  getOrderById,
  updatePaymentStatus
} from '../controllers/order.controller';
import { protect } from '../middleware/auth.middleware';

const router = express.Router();

// All routes are protected
router.use(protect);

// Create order from cart
router.post('/', createOrder as RequestHandler);

// Get user's orders
router.get('/user', getUserOrders as RequestHandler);

// Get product orders (for adoption centres)
router.get('/product/:productId', getProductOrders as RequestHandler);

// Get order by ID
router.get('/:id', getOrderById as RequestHandler);

// Update order status
router.put('/:id/status', updateOrderStatus as RequestHandler);

// Update payment status
router.put('/:id/payment', updatePaymentStatus as RequestHandler);

export default router; 