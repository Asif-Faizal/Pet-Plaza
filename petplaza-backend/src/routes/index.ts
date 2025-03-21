import express, { Router } from 'express';
import petRoutes from './pet.routes';
import userRoutes from './user.routes';

const router: Router = express.Router();

// Health check route
router.get('/', (req, res) => {
  res.status(200).json({ message: 'Pet Plaza API is running' });
});

// API routes
router.use('/pets', petRoutes);
router.use('/users', userRoutes);

export default router; 