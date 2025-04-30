import mongoose, { Schema, Document } from 'mongoose';

export interface IPet extends Document {
  name: string;
  petType: string;
  breed: string;
  gender: 'male' | 'female';
  age: number;
  ownerName: string;
  contactNumber: string;
  contactAddress: string;
  behavior: string;
  description: string;
  images: string[];
  adoptionCentre: mongoose.Types.ObjectId;
  status: 'active' | 'inactive' | 'adopted';
  createdAt: Date;
  updatedAt: Date;
}

const petSchema: Schema = new Schema(
  {
    name: {
      type: String,
      required: [true, 'Please enter pet name'],
      trim: true,
    },
    petType: {
      type: String,
      required: [true, 'Please enter pet type'],
      trim: true,
    },
    breed: {
      type: String,
      required: [true, 'Please enter breed'],
      trim: true,
    },
    gender: {
      type: String,
      required: [true, 'Please specify gender'],
      enum: ['male', 'female'],
    },
    age: {
      type: Number,
      required: [true, 'Please enter age'],
      min: [0, 'Age cannot be negative'],
    },
    ownerName: {
      type: String,
      required: [true, 'Please enter owner name'],
      trim: true,
    },
    contactNumber: {
      type: String,
      required: [true, 'Please enter contact number'],
      trim: true,
    },
    contactAddress: {
      type: String,
      required: [true, 'Please enter contact address'],
      trim: true,
    },
    behavior: {
      type: String,
      required: [true, 'Please describe pet behavior'],
      trim: true,
    },
    description: {
      type: String,
      required: [true, 'Please provide a description of the pet'],
      trim: true,
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
      required: true,
    },
    status: {
      type: String,
      required: true,
      enum: ['active', 'inactive', 'adopted'],
      default: 'active',
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model<IPet>('Pet', petSchema); 