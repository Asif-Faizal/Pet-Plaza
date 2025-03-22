import { Request, Response } from 'express';
import User from '../models/user.model';
import generateToken from '../utils/generateToken';

// Helper function to generate full URL for images
const getFullImageUrl = (req: Request, path: string): string => {
  if (!path) return '';
  // Get protocol and host
  const protocol = req.protocol;
  const host = req.get('host');
  return `${protocol}://${host}${path}`;
};

// @desc    Auth user & get token
// @route   POST /api/users/login
// @access  Public
export const login = async (req: Request, res: Response) => {
  try {
    const { identifier, passcode } = req.body;
    
    if (!identifier || !passcode) {
      return res.status(400).json({ message: 'Please provide email/phone number and passcode' });
    }
    
    // Find user by email or phone number
    const user = await User.findOne({ 
      $or: [
        { email: identifier },
        { phoneNumber: identifier }
      ]
    });
    
    if (!user) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }
    
    // Check if passcode matches
    if (passcode !== user.password) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }
    
    // Base response data common to all user types
    const responseData = {
      _id: user._id,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      userType: user.userType,
      isAdmin: user.isAdmin,
      token: generateToken(user.id)
    };
    
    // Add user type specific fields
    if (user.userType === 'adoption_centre') {
      Object.assign(responseData, {
        managerName: user.managerName,
        address: user.address,
        imageUrl: user.image ? getFullImageUrl(req, user.image) : null
      });
    } else if (user.userType === 'user') {
      Object.assign(responseData, {
        profilePicUrl: user.profilePic ? getFullImageUrl(req, user.profilePic) : null
      });
    }
    
    res.status(200).json({
      success: true,
      data: responseData
    });
  } catch (error: any) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// @desc    Register a new adoption centre
// @route   POST /api/users/register/adoption-centre
// @access  Public
export const registerAdoptionCentre = async (req: Request, res: Response) => {
  try {
    const { 
      name, 
      location, 
      managerName, 
      phoneNumber, 
      email, 
      address, 
      passcode 
    } = req.body;
    
    // Get image path from uploaded file
    const imagePath = req.file ? `/uploads/${req.file.filename}` : '';
    
    // Check if user already exists with this email or phone
    const userExists = await User.findOne({ 
      $or: [
        { email },
        { phoneNumber }
      ]
    });
    
    if (userExists) {
      return res.status(400).json({ 
        message: 'User already exists with this email or phone number' 
      });
    }
    
    // Validate passcode (6 digits)
    if (!passcode || !/^\d{6}$/.test(passcode)) {
      return res.status(400).json({ 
        message: 'Passcode must be exactly 6 digits' 
      });
    }
    
    // Create new adoption centre
    const adoptionCentre = await User.create({
      name,
      email,
      password: passcode,
      phoneNumber,
      location,
      managerName,
      address,
      image: imagePath,
      userType: 'adoption_centre',
    });
    
    if (adoptionCentre) {
      // Generate JWT token
      res.status(201).json({
        _id: adoptionCentre._id,
        name: adoptionCentre.name,
        email: adoptionCentre.email,
        phoneNumber: adoptionCentre.phoneNumber,
        userType: adoptionCentre.userType,
        imageUrl: getFullImageUrl(req, imagePath),
        token: generateToken(adoptionCentre.id)
      });
    } else {
      res.status(400).json({ message: 'Invalid adoption centre data' });
    }
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
};

// @desc    Register a new regular user
// @route   POST /api/users/register/user
// @access  Public
export const registerUser = async (req: Request, res: Response) => {
  try {
    const { 
      name, 
      phoneNumber, 
      email, 
      location, 
      passcode 
    } = req.body;
    
    // Get profile pic path from uploaded file
    const profilePicPath = req.file ? `/uploads/${req.file.filename}` : '';
    
    // Check if user already exists with this email or phone
    const userExists = await User.findOne({ 
      $or: [
        { email },
        { phoneNumber }
      ]
    });
    
    if (userExists) {
      return res.status(400).json({ 
        message: 'User already exists with this email or phone number' 
      });
    }
    
    // Validate passcode (6 digits)
    if (!passcode || !/^\d{6}$/.test(passcode)) {
      return res.status(400).json({ 
        message: 'Passcode must be exactly 6 digits' 
      });
    }
    
    // Create new user
    const user = await User.create({
      name,
      email,
      password: passcode,
      phoneNumber,
      location,
      profilePic: profilePicPath,
      userType: 'user',
    });
    
    if (user) {
      // Generate JWT token
      res.status(201).json({
        _id: user._id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        userType: user.userType,
        profilePicUrl: getFullImageUrl(req, profilePicPath),
        token: generateToken(user.id)
      });
    } else {
      res.status(400).json({ message: 'Invalid user data' });
    }
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
};

// @desc    Get user profile
// @route   GET /api/users/profile
// @access  Private
export const getUserProfile = async (req: Request, res: Response) => {
  try {
    // In a real app, you would get user ID from JWT token
    // For now, we'll just get a sample user
    const user = await User.findOne({});
    
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }
    
    const responseData = {
      _id: user._id,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      userType: user.userType,
      isAdmin: user.isAdmin,
    };
    
    // Add image URL based on user type
    if (user.userType === 'adoption_centre' && user.image) {
      Object.assign(responseData, { 
        imageUrl: getFullImageUrl(req, user.image) 
      });
    } else if (user.userType === 'user' && user.profilePic) {
      Object.assign(responseData, { 
        profilePicUrl: getFullImageUrl(req, user.profilePic) 
      });
    }
    
    res.status(200).json(responseData);
  } catch (error: any) {
    res.status(500).json({ message: error.message });
  }
};

// @desc    Update user profile
// @route   PUT /api/users/profile
// @access  Private
export const updateUserProfile = async (req: Request, res: Response) => {
  try {
    // In a real app, you would get user ID from JWT token
    // For now, we'll just get a sample user
    const user = await User.findOne({});
    
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }
    
    // Update user fields
    user.name = req.body.name || user.name;
    user.email = req.body.email || user.email;
    user.phoneNumber = req.body.phoneNumber || user.phoneNumber;
    user.location = req.body.location || user.location;
    
    let newImagePath = '';
    
    if (user.userType === 'adoption_centre') {
      user.managerName = req.body.managerName || user.managerName;
      user.address = req.body.address || user.address;
      
      // Update image if new file is uploaded
      if (req.file) {
        newImagePath = `/uploads/${req.file.filename}`;
        user.image = newImagePath;
      }
    } else if (user.userType === 'user') {
      // Update profile pic if new file is uploaded
      if (req.file) {
        newImagePath = `/uploads/${req.file.filename}`;
        user.profilePic = newImagePath;
      }
    }
    
    if (req.body.passcode && /^\d{6}$/.test(req.body.passcode)) {
      user.password = req.body.passcode;
    }
    
    const updatedUser = await user.save();
    
    const responseData = {
      _id: updatedUser._id,
      name: updatedUser.name,
      email: updatedUser.email,
      phoneNumber: updatedUser.phoneNumber,
      userType: updatedUser.userType,
      isAdmin: updatedUser.isAdmin,
      token: generateToken(updatedUser.id)
    };
    
    // Add image URL based on user type
    if (updatedUser.userType === 'adoption_centre' && updatedUser.image) {
      Object.assign(responseData, { 
        imageUrl: getFullImageUrl(req, updatedUser.image) 
      });
    } else if (updatedUser.userType === 'user' && updatedUser.profilePic) {
      Object.assign(responseData, { 
        profilePicUrl: getFullImageUrl(req, updatedUser.profilePic) 
      });
    }
    
    res.status(200).json(responseData);
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
}; 