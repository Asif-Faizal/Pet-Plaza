import mongoose, { Schema, Document } from 'mongoose';

export interface IPetProduct extends Document {
  name: string;
  description: string;
  price: number;
  petType: string;
  category: 'food' | 'nutrition' | 'toys' | 'accessories';
  images: string[];
  adoptionCentre?: mongoose.Types.ObjectId;
  stock: number;
  createdAt: Date;
  updatedAt: Date;
}

const petProductSchema: Schema = new Schema(
  {
    name: {
      type: String,
      required: [true, 'Please enter product name'],
      trim: true,
    },
    description: {
      type: String,
      required: [true, 'Please enter product description'],
      trim: true,
    },
    price: {
      type: Number,
      required: [true, 'Please enter product price'],
      min: [0, 'Price cannot be negative'],
    },
    petType: {
      type: String,
      required: [true, 'Please specify pet type'],
      trim: true,
    },
    category: {
      type: String,
      required: [true, 'Please specify product category'],
      enum: ['food', 'nutrition', 'toys', 'accessories'],
    },
    images: {
      type: [String],
      validate: {
        validator: function(images: string[]) {
          return images.length <= 4;
        },
        message: 'Maximum 4 images allowed'
      }
    },
    adoptionCentre: {
      type: Schema.Types.ObjectId,
      ref: 'User',
    },
    stock: {
      type: Number,
      required: [true, 'Please enter stock quantity'],
      min: [0, 'Stock cannot be negative'],
      default: 0,
    },
  },
  {
    timestamps: true,
  }
);

// Index for faster queries
petProductSchema.index({ petType: 1 });
petProductSchema.index({ category: 1 });
petProductSchema.index({ adoptionCentre: 1 });

export default mongoose.model<IPetProduct>('PetProduct', petProductSchema); 