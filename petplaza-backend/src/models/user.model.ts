import mongoose, { Schema, Document } from 'mongoose';

export interface IUser extends Document {
  name: string;
  email: string;
  password: string;
  userType: 'adoption_centre' | 'user';
  phoneNumber: string;
  location: string;
  // For adoption center
  managerName?: string;
  address?: string;
  image?: string; // URL to image
  // For regular user
  profilePic?: string; // URL to profile picture
  isAdmin: boolean;
  createdAt: Date;
  updatedAt: Date;
}

const userSchema: Schema = new Schema(
  {
    name: {
      type: String,
      required: [true, 'Please enter your name'],
      trim: true,
    },
    email: {
      type: String,
      required: [true, 'Please enter your email'],
      unique: true,
      trim: true,
      lowercase: true,
      match: [/^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/, 'Please enter a valid email'],
    },
    password: {
      type: String,
      required: [true, 'Please enter a passcode'],
      minlength: [6, 'Passcode must be exactly 6 digits'],
      maxlength: [6, 'Passcode must be exactly 6 digits'],
      match: [/^\d{6}$/, 'Passcode must contain only digits'],
    },
    userType: {
      type: String,
      required: [true, 'Please specify user type'],
      enum: ['adoption_centre', 'user'],
    },
    phoneNumber: {
      type: String,
      required: [true, 'Please enter your phone number'],
      unique: true,
    },
    location: {
      type: String,
      required: [true, 'Please enter your location'],
    },
    // Adoption center specific fields
    managerName: {
      type: String,
      required: function(this: IUser) { return this.userType === 'adoption_centre'; }
    },
    address: {
      type: String,
      required: function(this: IUser) { return this.userType === 'adoption_centre'; }
    },
    image: {
      type: String,
      required: function(this: IUser) { return this.userType === 'adoption_centre'; }
    },
    // Regular user specific fields
    profilePic: {
      type: String,
      required: function(this: IUser) { return this.userType === 'user'; }
    },
    isAdmin: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model<IUser>('User', userSchema); 