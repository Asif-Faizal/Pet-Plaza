import { Request, Response } from 'express';
import Cart from '../models/cart.model';
import PetProduct from '../models/petProduct.model';

// @desc    Add item to cart
// @route   POST /api/cart
export const addToCart = async (req: Request, res: Response) => {
  try {
    const { productId, quantity } = req.body;
    
    // Ensure user is authenticated
    if (!req.user || !req.user._id) {
      return res.status(401).json({
        success: false,
        message: 'User not authenticated'
      });
    }

    const userId = req.user._id;

    // Get the product
    const product = await PetProduct.findById(productId);
    if (!product) {
      return res.status(404).json({
        success: false,
        message: 'Product not found'
      });
    }

    // Check if product is in stock
    if (product.stock < quantity) {
      return res.status(400).json({
        success: false,
        message: 'Insufficient stock'
      });
    }

    // Find user's cart or create a new one
    let cart = await Cart.findOne({ user: userId });
    
    if (!cart) {
      // Create a new cart if doesn't exist
      cart = await Cart.create({
        user: userId,
        items: [{
          product: productId,
          quantity,
          price: product.price
        }],
        totalAmount: product.price * quantity
      });
    } else {
      // Check if product already exists in cart
      const existingItemIndex = cart.items.findIndex(
        item => item.product.toString() === productId
      );

      if (existingItemIndex > -1) {
        // Update quantity if product already in cart
        cart.items[existingItemIndex].quantity += quantity;
      } else {
        // Add new product to cart
        cart.items.push({
          product: productId,
          quantity,
          price: product.price
        });
      }

      // Recalculate total amount
      cart.totalAmount = cart.items.reduce(
        (total, item) => total + (item.price * item.quantity), 0
      );

      await cart.save();
    }

    res.status(200).json({
      success: true,
      data: cart
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Get user's cart
// @route   GET /api/cart
export const getCart = async (req: Request, res: Response) => {
  try {
    const userId = req.user?._id;

    const cart = await Cart.findOne({ user: userId })
      .populate('items.product', 'name price images stock');

    if (!cart) {
      return res.status(200).json({
        success: true,
        data: { user: userId, items: [], totalAmount: 0 }
      });
    }

    res.status(200).json({
      success: true,
      data: cart
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Update cart item quantity
// @route   PUT /api/cart/:productId
export const updateCartItem = async (req: Request, res: Response) => {
  try {
    const { productId } = req.params;
    const { quantity } = req.body;
    const userId = req.user?._id;

    // Validate quantity
    if (quantity < 1) {
      return res.status(400).json({
        success: false,
        message: 'Quantity must be at least 1'
      });
    }

    // Get the product to check stock
    const product = await PetProduct.findById(productId);
    if (!product) {
      return res.status(404).json({
        success: false,
        message: 'Product not found'
      });
    }

    // Check if product is in stock
    if (product.stock < quantity) {
      return res.status(400).json({
        success: false,
        message: 'Insufficient stock'
      });
    }

    // Find user's cart
    const cart = await Cart.findOne({ user: userId });
    if (!cart) {
      return res.status(404).json({
        success: false,
        message: 'Cart not found'
      });
    }

    // Find product in cart
    const itemIndex = cart.items.findIndex(
      item => item.product.toString() === productId
    );

    if (itemIndex === -1) {
      return res.status(404).json({
        success: false,
        message: 'Product not found in cart'
      });
    }

    // Update quantity
    cart.items[itemIndex].quantity = quantity;

    // Recalculate total amount
    cart.totalAmount = cart.items.reduce(
      (total, item) => total + (item.price * item.quantity), 0
    );

    await cart.save();

    res.status(200).json({
      success: true,
      data: cart
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Remove item from cart
// @route   DELETE /api/cart/:productId
export const removeCartItem = async (req: Request, res: Response) => {
  try {
    const { productId } = req.params;
    const userId = req.user?._id;

    // Find user's cart
    const cart = await Cart.findOne({ user: userId });
    if (!cart) {
      return res.status(404).json({
        success: false,
        message: 'Cart not found'
      });
    }

    // Remove product from cart
    cart.items = cart.items.filter(
      item => item.product.toString() !== productId
    );

    // Recalculate total amount
    cart.totalAmount = cart.items.reduce(
      (total, item) => total + (item.price * item.quantity), 0
    );

    await cart.save();

    res.status(200).json({
      success: true,
      data: cart
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Clear cart
// @route   DELETE /api/cart
export const clearCart = async (req: Request, res: Response) => {
  try {
    const userId = req.user?._id;

    const result = await Cart.findOneAndUpdate(
      { user: userId },
      { items: [], totalAmount: 0 },
      { new: true }
    );

    if (!result) {
      return res.status(404).json({
        success: false,
        message: 'Cart not found'
      });
    }

    res.status(200).json({
      success: true,
      message: 'Cart cleared successfully'
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
}; 