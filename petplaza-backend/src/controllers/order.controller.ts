import { Request, Response } from 'express';
import Order from '../models/order.model';
import PetProduct from '../models/petProduct.model';

// @desc    Create a new order
// @route   POST /api/orders
export const createOrder = async (req: Request, res: Response) => {
  try {
    const { productId, quantity, shippingAddress } = req.body;
    
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

    // Calculate total price
    const totalPrice = product.price * quantity;

    // Create the order
    const order = await Order.create({
      product: productId,
      user: userId,
      quantity,
      totalPrice,
      shippingAddress
    });

    // Update product stock
    product.stock -= quantity;
    await product.save();

    res.status(201).json({
      success: true,
      data: order
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Get user's orders
// @route   GET /api/orders/user
export const getUserOrders = async (req: Request, res: Response) => {
  try {
    const userId = req.user?._id;

    const orders = await Order.find({ user: userId })
      .populate('product', 'name price images')
      .sort({ createdAt: -1 });

    res.status(200).json({
      success: true,
      count: orders.length,
      data: orders
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Get orders for a product (for adoption centres)
// @route   GET /api/orders/product/:productId
export const getProductOrders = async (req: Request, res: Response) => {
  try {
    const { productId } = req.params;

    // Verify the product belongs to the adoption centre
    const product = await PetProduct.findById(productId);
    if (!product) {
      return res.status(404).json({
        success: false,
        message: 'Product not found'
      });
    }

    const orders = await Order.find({ product: productId })
      .populate('user', 'name email contactNumber')
      .sort({ createdAt: -1 });

    res.status(200).json({
      success: true,
      count: orders.length,
      data: orders
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Update order status
// @route   PUT /api/orders/:id/status
export const updateOrderStatus = async (req: Request, res: Response) => {
  try {
    const { status } = req.body;
    const { id } = req.params;

    const order = await Order.findById(id);
    if (!order) {
      return res.status(404).json({
        success: false,
        message: 'Order not found'
      });
    }

    // Verify the product belongs to the adoption centre
    const product = await PetProduct.findById(order.product);
    if (!product) {
      return res.status(404).json({
        success: false,
        message: 'Product not found'
      });
    }

    order.status = status;
    await order.save();

    res.status(200).json({
      success: true,
      data: order
    });
  } catch (error: any) {
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
}; 