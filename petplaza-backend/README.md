# PetPlaza Backend

## Overview
This is the backend for the PetPlaza application, providing RESTful APIs for user management, pet adoption, product sales, and more.

## Setup
1. Install dependencies:
   ```bash
   npm install
   ```
2. Start the server:
   ```bash
   npm run dev
   ```

## API Endpoints

### Health Check
- `GET /api/` — Returns API status.

### Users (`/api/users`)
- `POST /login` — User login
- `POST /register/user` — Register user (with profilePic upload)
- `POST /register/adoption-centre` — Register adoption centre (with image upload)
- `GET /profile` — Get user profile
- `PUT /profile` — Update user or centre profile (with optional image upload)

### Pets (`/api/pets`)
- `GET /` — List all pets
- `GET /filter` — Filter pets by type and status
- `GET /centre` — List pets by adoption centre (protected)
- `POST /` — Add a new pet (protected, with up to 4 images)
- `PUT /:id/status` — Update pet status (protected)
- `GET /:id` — Get pet by ID

### Adoption Requests (`/api/adoption-requests`)
- `POST /` — Create adoption request (protected)
- `GET /user` — Get user's adoption requests (protected)
- `GET /centre` — Get centre's adoption requests (protected)
- `PUT /:id/status` — Update adoption request status (protected)

### Pet Products (`/api/pet-products`)
- `GET /` — List all pet products
- `GET /centre/:centreId` — List products by centre
- `POST /` — Add pet product (with up to 4 images)

### Orders (`/api/orders`)
- `POST /` — Create order from cart (protected)
- `GET /user` — Get user's orders (protected)
- `GET /product/:productId` — Get product orders (for centres, protected)
- `GET /:id` — Get order by ID (protected)
- `PUT /:id/status` — Update order status (protected)
- `PUT /:id/payment` — Update payment status (protected)

### Cart (`/api/cart`)
- `POST /` — Add to cart (protected)
- `GET /` — Get user's cart (protected)
- `PUT /:productId` — Update cart item quantity (protected)
- `DELETE /:productId` — Remove item from cart (protected)
- `DELETE /` — Clear cart (protected)

## Middleware
- **Authentication:** Most routes require authentication via middleware.
- **File Uploads:** Handled via `multer` middleware for images.

## Notes
- Ensure environment variables are set for DB and JWT.
- See source for more details on controllers and models.

## Project Structure

```
petplaza-backend/
├── src/
│   ├── controllers/     # Route controllers
│   ├── models/          # Mongoose models
│   ├── routes/          # API routes
│   ├── middleware/      # Custom middleware
│   ├── utils/           # Utility functions
│   ├── config/          # Configuration files
│   └── index.ts         # App entry point
├── dist/                # Compiled JavaScript
├── .env                 # Environment variables
├── .gitignore           # Git ignore file
├── package.json         # Dependencies
├── tsconfig.json        # TypeScript config
└── README.md            # Project documentation
```

## License

MIT 