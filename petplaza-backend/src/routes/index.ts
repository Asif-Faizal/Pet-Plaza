import express, { Router } from 'express';
import userRoutes from './user.routes';
import petRoutes from './pet.routes';

const router: Router = express.Router();

// Health check route
router.get('/', (_req, res) => {
  res.status(200).json({ message: 'Pet Plaza API is running' });
});

router.use('/users', userRoutes);
router.use('/pets', petRoutes);

export default router; 