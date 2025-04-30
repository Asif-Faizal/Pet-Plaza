import express, { RequestHandler } from 'express';
import { 
  createAdoptionRequest,
  getUserAdoptionRequests,
  getCentreAdoptionRequests,
  updateAdoptionRequestStatus
} from '../controllers/adoptionRequest.controller';
import { protect } from '../middleware/auth.middleware';

const router = express.Router();

// User routes
router.post('/', protect, createAdoptionRequest as RequestHandler);
router.get('/user', protect, getUserAdoptionRequests as RequestHandler);

// Adoption Centre routes
router.get('/centre', protect, getCentreAdoptionRequests as RequestHandler);
router.put('/:id/status', protect, updateAdoptionRequestStatus as RequestHandler);

export default router; 