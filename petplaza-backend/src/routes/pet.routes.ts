import express, { RequestHandler } from 'express';
import { 
  addPet, 
  getPets, 
  getPetById, 
  updatePetStatus,
  getPetsByTypeAndStatus,
  getPetsByCentre
} from '../controllers/pet.controller';
import upload from '../middleware/upload.middleware';
import { protect } from '../middleware/auth.middleware';

const router = express.Router();

// Public routes
router.get('/', getPets as RequestHandler);
router.get('/filter', getPetsByTypeAndStatus as RequestHandler);

// Protected routes (Adoption Centre only)
router.get('/centre', protect, getPetsByCentre as RequestHandler);
router.post(
  '/',
  protect,
  upload.array('images', 4), // Allow up to 4 images
  addPet as RequestHandler
);

router.put(
  '/:id/status',
  protect,
  updatePetStatus as RequestHandler
);

router.get('/:id', getPetById as RequestHandler);

export default router; 