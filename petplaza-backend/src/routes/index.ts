import express, { Router } from 'express';
import userRoutes from './user.routes';
import petRoutes from './pet.routes';
import adoptionRequestRoutes from './adoptionRequest.routes';
import petProductRoutes from './petProduct.routes';

const router: Router = express.Router();

// Health check route
router.get('/', (_req, res) => {
  res.status(200).json({ message: 'Pet Plaza API is running' });
});

router.use('/users', userRoutes);
router.use('/pets', petRoutes);
router.use('/adoption-requests', adoptionRequestRoutes);
router.use('/pet-products', petProductRoutes);

export default router; 