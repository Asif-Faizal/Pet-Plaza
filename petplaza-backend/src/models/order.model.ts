import mongoose, { Schema, Document } from 'mongoose';

export interface IOrderItem {
  product: mongoose.Types.ObjectId;
  quantity: number;
  price: number;
}

export interface IAddress {
  street: string;
  city: string;
  state: string;
  postalCode: string;
  country: string;
}

export interface IOrder extends Document {
  user: mongoose.Types.ObjectId;
  items: IOrderItem[];
  totalAmount: number;
  shippingAddress: IAddress;
  paymentMethod: 'cod' | 'online';
  paymentStatus: 'pending' | 'completed' | 'failed';
  orderStatus: 'pending' | 'processing' | 'shipped' | 'delivered' | 'cancelled';
  paymentId?: string;
  createdAt: Date;
  updatedAt: Date;
}

const addressSchema = new Schema({
  street: {
    type: String,
    required: [true, 'Street address is required'],
    trim: true,
  },
  city: {
    type: String,
    required: [true, 'City is required'],
    trim: true,
  },
  state: {
    type: String,
    required: [true, 'State is required'],
    trim: true,
  },
  postalCode: {
    type: String,
    required: [true, 'Postal code is required'],
    trim: true,
  },
  country: {
    type: String,
    required: [true, 'Country is required'],
    trim: true,
  },
});

const orderItemSchema = new Schema({
  product: {
    type: Schema.Types.ObjectId,
    ref: 'PetProduct',
    required: true,
  },
  quantity: {
    type: Number,
    required: true,
    min: [1, 'Quantity must be at least 1'],
  },
  price: {
    type: Number,
    required: true,
    min: [0, 'Price cannot be negative'],
  },
});

const orderSchema: Schema = new Schema(
  {
    user: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    items: [orderItemSchema],
totalAmount: {
   type: Number,
   required: true,
  min: [0, 'Total amount cannot be negative'],
 },
    shippingAddress: {
      type: addressSchema,
      required: true,
    },
    paymentMethod: {
      type: String,
      enum: ['cod', 'online'],
      required: true,
    },
    paymentStatus: {
      type: String,
      enum: ['pending', 'completed', 'failed'],
      default: 'pending',
    },
    orderStatus: {
      type: String,
      enum: ['pending', 'processing', 'shipped', 'delivered', 'cancelled'],
      default: 'pending',
    },
    paymentId: {
      type: String,
    },
  },
  {
    timestamps: true,
  }
);

// Index for faster queries
orderSchema.index({ user: 1 });
orderSchema.index({ orderStatus: 1 });
orderSchema.index({ paymentStatus: 1 });

export default mongoose.model<IOrder>('Order', orderSchema); 