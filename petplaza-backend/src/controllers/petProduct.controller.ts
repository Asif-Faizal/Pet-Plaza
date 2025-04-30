import { Request, Response } from 'express';
import PetProduct from '../models/petProduct.model';

// Helper function to generate full URL for images
const getFullImageUrl = (req: Request, path: string): string => {
  if (!path) return '';
  const protocol = req.protocol;
  const host = req.get('host');
  return `${protocol}://${host}${path}`;
};

// @desc    Add a new pet product
// @route   POST /api/pet-products
export const addPetProduct = async (req: Request, res: Response) => {
  try {
    const {
      name,
      description,
      price,
      petType,
      category,
      stock,
      adoptionCentre
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

    const product = await PetProduct.create({
      name,
      description,
      price,
      petType,
      category,
      images,
      stock,
      ...(adoptionCentre && { adoptionCentre }) // Only include if provided
    });

    // Generate full URLs for images
    const imageUrls = images.map(image => getFullImageUrl(req, image));

    res.status(201).json({
      success: true,
      data: {
        ...product.toObject(),
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

// @desc    Get all pet products with filters
// @route   GET /api/pet-products
export const getPetProducts = async (req: Request, res: Response) => {
  try {
    const { petType, category } = req.query;

    // Build filter object
    const filter: any = {};
    
    if (petType) {
      filter.petType = petType;
    }
    
    if (category) {
      filter.category = category;
    }

    const products = await PetProduct.find(filter)
      .populate('adoptionCentre', 'name location')
      .sort({ createdAt: -1 });

    // Add full URLs for images
    const productsWithUrls = products.map(product => ({
      ...product.toObject(),
      imageUrls: product.images.map(image => getFullImageUrl(req, image))
    }));

    res.status(200).json({
      success: true,
      count: products.length,
      data: productsWithUrls
    });
  } catch (error: any) {
    res.status(500).json({ 
      success: false, 
      message: error.message 
    });
  }
};

// @desc    Get pet products by adoption centre
// @route   GET /api/pet-products/centre/:centreId
export const getPetProductsByCentre = async (req: Request, res: Response) => {
  try {
    const { centreId } = req.params;

    const products = await PetProduct.find({ adoptionCentre: centreId })
      .populate('adoptionCentre', 'name location')
      .sort({ createdAt: -1 });

    // Add full URLs for images
    const productsWithUrls = products.map(product => ({
      ...product.toObject(),
      imageUrls: product.images.map(image => getFullImageUrl(req, image))
    }));

    res.status(200).json({
      success: true,
      count: products.length,
      data: productsWithUrls
    });
  } catch (error: any) {
    res.status(500).json({ 
      success: false, 
      message: error.message 
    });
  }
}; 