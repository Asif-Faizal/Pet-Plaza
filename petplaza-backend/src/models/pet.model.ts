import mongoose, { Schema, Document } from 'mongoose';

export interface IPet extends Document {
  name: string;
  species: string;
  breed: string;
  age: number;
  weight: number;
  owner: mongoose.Types.ObjectId;
  description: string;
  medicalHistory: string[];
  imageUrl: string;
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
    species: {
      type: String,
      required: [true, 'Please enter pet species'],
      trim: true,
    },
    breed: {
      type: String,
      required: false,
      trim: true,
    },
    age: {
      type: Number,
      required: false,
    },
    weight: {
      type: Number,
      required: false,
    },
    owner: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    description: {
      type: String,
      required: false,
    },
    medicalHistory: [{
      type: String,
      required: false,
    }],
    imageUrl: {
      type: String,
      required: false,
    }
  },
  {
    timestamps: true,
  }
);

export default mongoose.model<IPet>('Pet', petSchema); 