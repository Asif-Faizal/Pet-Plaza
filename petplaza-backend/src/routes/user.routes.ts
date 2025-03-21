import express, { RequestHandler } from 'express';
import { 
  login, 
  registerUser,
  registerAdoptionCentre,
  getUserProfile, 
  updateUserProfile 
} from '../controllers/user.controller';
import upload from '../middleware/upload.middleware';

const router = express.Router();

// Routes for /api/users
router.post('/login', login as RequestHandler);

// Register routes with file upload
router.post(
  '/register/user', 
  upload.single('profilePic'), 
  registerUser as RequestHandler
);

router.post(
  '/register/adoption-centre', 
  upload.single('image'), 
  registerAdoptionCentre as RequestHandler
);

router.get('/profile', getUserProfile as RequestHandler);

// Update profile with optional file upload
router.put(
  '/profile', 
  upload.single('image'), // Will handle both profile pic and center image
  updateUserProfile as RequestHandler
);

export default router; 