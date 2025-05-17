import { Request, Response } from 'express';
import Order from '../models/order.model';
import Cart from '../models/cart.model';
import PetProduct from '../models/petProduct.model';

// @desc    Create a new order from cart
// @route   POST /api/orders
export const createOrder = async (req: Request, res: Response) => {
  try {
    const { 
      shippingAddress, 
      paymentMethod 
    } = req.body;
    
    // Ensure user is authenticated
    if (!req.user || !req.user._id) {
      return res.status(401).json({
        success: false,
        message: 'User not authenticated'
      });
    }

    const userId = req.user._id;

    // Get user's cart
    const cart = await Cart.findOne({ user: userId })
      .populate('items.product');
    
    if (!cart || cart.items.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Cart is empty'
      });
    }

    // Verify all items are in stock
    for (const item of cart.items) {
      const product = item.product as any;
      if (product.stock < item.quantity) {
        return res.status(400).json({
          success: false,
          message: `Insufficient stock for ${product.name}`
        });
      }
    }

    // Create order from cart
    const order = await Order.create({
      user: userId,
      items: cart.items.map(item => ({
        product: item.product,
        quantity: item.quantity,
        price: item.price
      })),
      totalAmount: cart.totalAmount,
      shippingAddress,
      paymentMethod,
      paymentStatus: paymentMethod === 'cod' ? 'pending' : 'pending',
      orderStatus: 'pending'
    });

    // Update product stock
    for (const item of cart.items) {
      await PetProduct.findByIdAndUpdate(
        item.product,
        { $inc: { stock: -item.quantity } }
      );
    }

    // Clear the cart after order creation
    await Cart.findOneAndUpdate(
      { user: userId },
      { items: [], totalAmount: 0 }
    );

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
      .populate('items.product', 'name price images')
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

    const orders = await Order.find({ 'items.product': productId })
      .populate('user', 'name email phoneNumber')
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
    const { orderStatus } = req.body;
    const { id } = req.params;

    const order = await Order.findById(id);
    if (!order) {
      return res.status(404).json({
        success: false,
        message: 'Order not found'
      });
    }

    order.orderStatus = orderStatus;
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

// @desc    Get order by ID
// @route   GET /api/orders/:id
export const getOrderById = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;

    const order = await Order.findById(id)
      .populate('items.product', 'name price images')
      .populate('user', 'name email phoneNumber');

    if (!order) {
      return res.status(404).json({
        success: false,
        message: 'Order not found'
      });
    }

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

// @desc    Update payment status
// @route   PUT /api/orders/:id/payment
export const updatePaymentStatus = async (req: Request, res: Response) => {
  try {
    const { paymentStatus, paymentId } = req.body;
    const { id } = req.params;

    const order = await Order.findById(id);
    if (!order) {
      return res.status(404).json({
        success: false,
        message: 'Order not found'
      });
    }

    order.paymentStatus = paymentStatus;
    if (paymentId) {
      order.paymentId = paymentId;
    }
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