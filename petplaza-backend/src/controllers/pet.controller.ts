import { Request, Response } from 'express';
import Pet from '../models/pet.model';
import User from '../models/user.model';

// Helper function to generate full URL for images
const getFullImageUrl = (req: Request, path: string): string => {
  if (!path) return '';
  const protocol = req.protocol;
  const host = req.get('host');
  return `${protocol}://${host}${path}`;
};

// Type for populated adoption centre
interface PopulatedAdoptionCentre {
  _id: string;
  name: string;
  location: string;
  image?: string;
}

// @desc    Add a new pet
// @route   POST /api/pets
// @access  Private (Adoption Centre only)
export const addPet = async (req: Request, res: Response) => {
  try {
    // Check if user is an adoption centre
    const adoptionCentre = await User.findById(req.user?._id);
    
    if (!adoptionCentre || adoptionCentre.userType !== 'adoption_centre') {
      return res.status(403).json({ 
        success: false, 
        message: 'Only adoption centres can add pets' 
      });
    }

    const {
      name,
      petType,
      breed,
      gender,
      age,
      ownerName,
      contactNumber,
      contactAddress,
      behavior,
      description
    } = req.body;

    // Get image paths from uploaded files
    const images = req.files ? 
      (req.files as Express.Multer.File[]).map(file => `/uploads/${file.filename}`) : 
      [];

    // Validate number of images
    if (images.length > 4) {
      return res.status(400).json({
        success: false,
        message: 'Maximum 4 images allowed'
      });
    }

    const pet = await Pet.create({
      name,
      petType,
      breed,
      gender,
      age,
      ownerName,
      contactNumber,
      contactAddress,
      behavior,
      description,
      images,
      adoptionCentre: adoptionCentre._id
    });

    // Generate full URLs for images
    const imageUrls = images.map(image => getFullImageUrl(req, image));

    res.status(201).json({
      success: true,
      data: {
        ...pet.toObject(),
        imageUrls
      }
    });
  } catch (error: any) {
    res.status(400).json({ 
      success: false, 
      message: error.message 
    });
  }
};

// @desc    Get all pets
// @route   GET /api/pets
// @access  Public
export const getPets = async (req: Request, res: Response) => {
  try {
    const pets = await Pet.find({ status: 'available' })
      .populate<{ adoptionCentre: PopulatedAdoptionCentre }>('adoptionCentre', 'name location image')
      .sort({ createdAt: -1 });

    // Add full URLs for images
    const petsWithUrls = pets.map(pet => ({
      ...pet.toObject(),
      imageUrls: pet.images.map(image => getFullImageUrl(req, image)),
      adoptionCentre: {
        ...pet.adoptionCentre,
        imageUrl: pet.adoptionCentre.image ? 
          getFullImageUrl(req, pet.adoptionCentre.image) : null
      }
    }));

    res.status(200).json({
      success: true,
      data: petsWithUrls
    });
  } catch (error: any) {
    res.status(500).json({ 
      success: false, 
      message: error.message 
    });
  }
};

// @desc    Get pet by ID
// @route   GET /api/pets/:id
// @access  Public
export const getPetById = async (req: Request, res: Response) => {
  try {
    const pet = await Pet.findById(req.params.id)
      .populate<{ adoptionCentre: PopulatedAdoptionCentre }>('adoptionCentre', 'name location image');

    if (!pet) {
      return res.status(404).json({ 
        success: false, 
        message: 'Pet not found' 
      });
    }

    // Add full URLs for images
    const petWithUrls = {
      ...pet.toObject(),
      imageUrls: pet.images.map(image => getFullImageUrl(req, image)),
      adoptionCentre: {
        ...pet.adoptionCentre,
        imageUrl: pet.adoptionCentre.image ? 
          getFullImageUrl(req, pet.adoptionCentre.image) : null
      }
    };

    res.status(200).json({
      success: true,
      data: petWithUrls
    });
  } catch (error: any) {
    res.status(500).json({ 
      success: false, 
      message: error.message 
    });
  }
};

// @desc    Update pet status
// @route   PUT /api/pets/:id/status
// @access  Private (Adoption Centre only)
export const updatePetStatus = async (req: Request, res: Response) => {
  try {
    const { status } = req.body;
    const petId = req.params.id;

    // Check if user is an adoption centre
    const adoptionCentre = await User.findById(req.user?._id);
    
    if (!adoptionCentre || adoptionCentre.userType !== 'adoption_centre') {
      return res.status(403).json({ 
        success: false, 
        message: 'Only adoption centres can update pet status' 
      });
    }

    const pet = await Pet.findById(petId);

    if (!pet) {
      return res.status(404).json({ 
        success: false, 
        message: 'Pet not found' 
      });
    }

    // Check if the adoption centre owns this pet
    if (pet.adoptionCentre.toString() !== adoptionCentre.id.toString()) {
      return res.status(403).json({ 
        success: false, 
        message: 'Not authorized to update this pet' 
      });
    }

    // Validate the status value
    if (!['active', 'inactive', 'adopted'].includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status value. Must be one of: active, inactive, adopted'
      });
    }

    pet.status = status;
    await pet.save();

    res.status(200).json({
      success: true,
      data: pet
    });
  } catch (error: any) {
    res.status(400).json({ 
      success: false, 
      message: error.message 
    });
  }
};

// @desc    Get pets by type and status
// @route   GET /api/pets/filter
// @access  Public
export const getPetsByTypeAndStatus = async (req: Request, res: Response) => {
  try {
    const { petType, status } = req.query;

    // Build filter object
    const filter: any = {};
    
    if (petType) {
      filter.petType = petType;
    }
    
    if (status) {
      filter.status = status;
    }

    const pets = await Pet.find(filter)
      .populate('adoptionCentre', 'name location')
      .sort({ createdAt: -1 });

    // Add full URLs for images
    const petsWithUrls = pets.map(pet => ({
      ...pet.toObject(),
      imageUrls: pet.images.map(image => getFullImageUrl(req, image))
    }));

    res.status(200).json({
      success: true,
      count: pets.length,
      data: petsWithUrls
    });
  } catch (error: any) {
    res.status(500).json({ 
      success: false, 
      message: error.message 
    });
  }
}; 