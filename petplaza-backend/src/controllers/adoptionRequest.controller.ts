import { Request, Response } from 'express';
import AdoptionRequest from '../models/adoptionRequest.model';
import Pet from '../models/pet.model';
import User from '../models/user.model';

interface IAdoptionCentre {
  _id: string;
  name: string;
  location: string;
  phoneNumber?: string;
  address?: string;
  email?: string;
}

// @desc    Create adoption request
// @route   POST /api/adoption-requests
// @access  Private (User only)
export const createAdoptionRequest = async (req: Request, res: Response) => {
  try {
    const { petId, note } = req.body;
    const userId = req.user?._id;

    // Check if user exists
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    // Check if pet exists and get adoption centre
    const pet = await Pet.findById(petId);
    if (!pet) {
      return res.status(404).json({
        success: false,
        message: 'Pet not found'
      });
    }

    // Check if pet is available
    if (pet.status !== 'active') {
      return res.status(400).json({
        success: false,
        message: 'Pet is not available for adoption'
      });
    }

    // Check if user already has a pending request for this pet
    const existingRequest = await AdoptionRequest.findOne({
      pet: petId,
      user: userId,
      status: 'pending'
    });

    if (existingRequest) {
      return res.status(400).json({
        success: false,
        message: 'You already have a pending request for this pet'
      });
    }

    const adoptionRequest = await AdoptionRequest.create({
      pet: petId,
      user: userId,
      adoptionCentre: pet.adoptionCentre,
      note
    });

    res.status(201).json({
      success: true,
      data: adoptionRequest
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Get user's adoption requests
// @route   GET /api/adoption-requests/user
// @access  Private (User only)
export const getUserAdoptionRequests = async (req: Request, res: Response) => {
  try {
    const userId = req.user?._id;

    const requests = await AdoptionRequest.find({ user: userId })
      .populate('pet', 'name petType breed images status')
      .populate<{ adoptionCentre: IAdoptionCentre }>('adoptionCentre', 'name location phoneNumber address email')
      .sort({ createdAt: -1 });

    // Format the response to include adoption centre contact details
    const formattedRequests = requests.map(request => {
      const requestObj = request.toObject();
      
      // If request is declined, only show basic adoption centre info
      if (requestObj.status === 'declined') {
        const { adoptionCentre, ...rest } = requestObj;
        return {
          ...rest,
          adoptionCentre: {
            _id: adoptionCentre._id,
            name: adoptionCentre.name,
            location: adoptionCentre.location
          }
        };
      }
      
      // For accepted and pending requests, show all adoption centre details
      return {
        ...requestObj,
        adoptionCentre: {
          _id: requestObj.adoptionCentre._id,
          name: requestObj.adoptionCentre.name,
          location: requestObj.adoptionCentre.location,
          contactNumber: requestObj.adoptionCentre.phoneNumber,
          contactAddress: requestObj.adoptionCentre.address,
          email: requestObj.adoptionCentre.email
        }
      };
    });

    res.status(200).json({
      success: true,
      count: formattedRequests.length,
      data: formattedRequests
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Get adoption centre's received requests
// @route   GET /api/adoption-requests/centre
// @access  Private (Adoption Centre only)
export const getCentreAdoptionRequests = async (req: Request, res: Response) => {
  try {
    const centreId = req.user?._id;

    const requests = await AdoptionRequest.find({ adoptionCentre: centreId })
      .populate('pet', 'name petType breed images status')
      .populate('user', 'name email contactNumber contactAddress')
      .sort({ createdAt: -1 });

    res.status(200).json({
      success: true,
      count: requests.length,
      data: requests
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Update adoption request status
// @route   PUT /api/adoption-requests/:id/status
// @access  Private (Adoption Centre only)
export const updateAdoptionRequestStatus = async (req: Request, res: Response) => {
  try {
    const { status } = req.body;
    const requestId = req.params.id;
    const centreId = req.user?._id;

    // Check if request exists and belongs to the centre
    const request = await AdoptionRequest.findById(requestId);
    if (!request) {
      return res.status(404).json({
        success: false,
        message: 'Adoption request not found'
      });
    }

    if (request.adoptionCentre.toString() !== centreId.toString()) {
      return res.status(403).json({
        success: false,
        message: 'Not authorized to update this request'
      });
    }

    // Update request status
    request.status = status;
    await request.save();

    // If accepted, update pet status to adopted
    if (status === 'accepted') {
      await Pet.findByIdAndUpdate(request.pet, { status: 'adopted' });
    }

    // Get updated request with populated data
    const updatedRequest = await AdoptionRequest.findById(requestId)
      .populate('pet', 'name petType breed images status')
      .populate('user', 'name email contactNumber contactAddress')
      .populate('adoptionCentre', 'name location');

    res.status(200).json({
      success: true,
      data: updatedRequest
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
}; 