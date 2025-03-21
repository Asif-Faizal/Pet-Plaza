import jwt from 'jsonwebtoken';

/**
 * Generate a JWT token
 * @param id User ID to encode in the token
 * @returns JWT token string
 */
const generateToken = (id: string): string => {
  return jwt.sign({ id }, process.env.JWT_SECRET as string, {
    expiresIn: '30d',
  });
};

export default generateToken; 