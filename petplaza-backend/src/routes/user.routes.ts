import express, { Router } from 'express';
import { login, register, getUserProfile, updateUserProfile } from '../controllers/user.controller';

const router: Router = express.Router();

// Routes for /api/users
router.post('/login', login);
router.post('/register', register);
router.get('/profile', getUserProfile);
router.put('/profile', updateUserProfile);

export default router; 