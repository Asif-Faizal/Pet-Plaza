import mongoose, { Schema, Document } from 'mongoose';

export interface IAdoptionRequest extends Document {
  pet: mongoose.Types.ObjectId;
  user: mongoose.Types.ObjectId;
  adoptionCentre: mongoose.Types.ObjectId;
  note: string;
  status: 'pending' | 'accepted' | 'declined';
  createdAt: Date;
  updatedAt: Date;
}

const adoptionRequestSchema: Schema = new Schema(
  {
    pet: {
      type: Schema.Types.ObjectId,
      ref: 'Pet',
      required: true,
    },
    user: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    adoptionCentre: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    note: {
      type: String,
      required: [true, 'Please add a note for your adoption request'],
      trim: true,
    },
    status: {
      type: String,
      enum: ['pending', 'accepted', 'declined'],
      default: 'pending',
    },
  },
  {
    timestamps: true,
  }
);

// Index for faster queries
adoptionRequestSchema.index({ user: 1 });
adoptionRequestSchema.index({ adoptionCentre: 1 });
adoptionRequestSchema.index({ pet: 1 });

export default mongoose.model<IAdoptionRequest>('AdoptionRequest', adoptionRequestSchema); 