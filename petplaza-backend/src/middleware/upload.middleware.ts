import path from 'path';
import multer from 'multer';
import { Request } from 'express';

// Set up storage for uploaded files
const storage = multer.diskStorage({
  destination: (_req, _file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (_req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
    cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
  }
});

// Filter for image files
const imageFilter = (_req: Request, file: Express.Multer.File, cb: multer.FileFilterCallback) => {
  // Accept images only
  if (!file.originalname.match(/\.(jpg|jpeg|png|gif)$/i)) {
    return cb(new Error('Only image files are allowed!'));
  }
  cb(null, true);
};

// Maximum file size (5MB)
const maxSize = 5 * 1024 * 1024;

// Create the multer instance
const upload = multer({ 
  storage: storage,
  fileFilter: imageFilter,
  limits: { fileSize: maxSize } 
});

export default upload; 