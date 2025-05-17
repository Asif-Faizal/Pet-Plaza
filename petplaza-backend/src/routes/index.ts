import express, { Router } from 'express';
import userRoutes from './user.routes';
import petRoutes from './pet.routes';
import adoptionRequestRoutes from './adoptionRequest.routes';
import petProductRoutes from './petProduct.routes';
import orderRoutes from './order.routes';
import cartRoutes from './cart.routes';

const router: Router = express.Router();

// Health check route
router.get('/', (_req, res) => {
  res.status(200).json({ message: 'Pet Plaza API is running' });
});

router.use('/users', userRoutes);
router.use('/pets', petRoutes);
router.use('/adoption-requests', adoptionRequestRoutes);
router.use('/pet-products', petProductRoutes);
router.use('/orders', orderRoutes);
router.use('/cart', cartRoutes);

export default router; 