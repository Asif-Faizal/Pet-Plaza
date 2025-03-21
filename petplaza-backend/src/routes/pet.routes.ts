import express, { Router } from 'express';
import { getAllPets, getPetById, createPet, updatePet, deletePet } from '../controllers/pet.controller';

const router: Router = express.Router();

// Routes for /api/pets
router.get('/', getAllPets);
router.get('/:id', getPetById);
router.post('/', createPet);
router.put('/:id', updatePet);
router.delete('/:id', deletePet);

export default router; 