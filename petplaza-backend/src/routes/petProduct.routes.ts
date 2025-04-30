import express, { RequestHandler } from 'express';
import { 
  addPetProduct, 
  getPetProducts,
  getPetProductsByCentre
} from '../controllers/petProduct.controller';
import upload from '../middleware/upload.middleware';

const router = express.Router();

// Public routes
router.get('/', getPetProducts as RequestHandler);
router.get('/centre/:centreId', getPetProductsByCentre as RequestHandler);

// Add product with images
router.post(
  '/',
  upload.array('images', 4), // Allow up to 4 images
  addPetProduct as RequestHandler
);

export default router; 