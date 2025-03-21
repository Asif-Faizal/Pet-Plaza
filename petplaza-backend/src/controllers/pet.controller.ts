import { Request, Response } from 'express';
import Pet from '../models/pet.model';

// @desc    Get all pets
// @route   GET /api/pets
// @access  Public
export const getAllPets = async (req: Request, res: Response) => {
  try {
    const pets = await Pet.find({});
    res.status(200).json(pets);
  } catch (error: any) {
    res.status(500).json({ message: error.message });
  }
};

// @desc    Get pet by ID
// @route   GET /api/pets/:id
// @access  Public
export const getPetById = async (req: Request, res: Response) => {
  try {
    const pet = await Pet.findById(req.params.id);
    
    if (!pet) {
      return res.status(404).json({ message: 'Pet not found' });
    }
    
    res.status(200).json(pet);
  } catch (error: any) {
    res.status(500).json({ message: error.message });
  }
};

// @desc    Create a pet
// @route   POST /api/pets
// @access  Private
export const createPet = async (req: Request, res: Response) => {
  try {
    const pet = await Pet.create(req.body);
    res.status(201).json(pet);
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
};

// @desc    Update a pet
// @route   PUT /api/pets/:id
// @access  Private
export const updatePet = async (req: Request, res: Response) => {
  try {
    const pet = await Pet.findById(req.params.id);
    
    if (!pet) {
      return res.status(404).json({ message: 'Pet not found' });
    }
    
    const updatedPet = await Pet.findByIdAndUpdate(
      req.params.id, 
      req.body, 
      { new: true }
    );
    
    res.status(200).json(updatedPet);
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
};

// @desc    Delete a pet
// @route   DELETE /api/pets/:id
// @access  Private
export const deletePet = async (req: Request, res: Response) => {
  try {
    const pet = await Pet.findById(req.params.id);
    
    if (!pet) {
      return res.status(404).json({ message: 'Pet not found' });
    }
    
    await Pet.deleteOne({ _id: req.params.id });
    
    res.status(200).json({ message: 'Pet removed' });
  } catch (error: any) {
    res.status(500).json({ message: error.message });
  }
}; 