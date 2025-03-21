# Pet Plaza Backend API

A RESTful API for the Pet Plaza application built with Node.js, Express, TypeScript, and MongoDB.

## Features

- User authentication with JWT
- CRUD operations for pets
- User profile management
- Secure API with proper authentication middleware
- TypeScript for better type safety and development experience

## Tech Stack

- Node.js
- Express.js
- TypeScript
- MongoDB with Mongoose ODM
- JWT for authentication
- Cors, Helmet for security

## Getting Started

### Prerequisites

- Node.js (v14+)
- MongoDB

### Installation

1. Clone the repository
```
git clone <repository-url>
```

2. Install dependencies
```
cd petplaza-backend
npm install
```

3. Set up environment variables
```
cp .env.example .env
```
Edit the `.env` file with your configuration.

4. Start development server
```
npm run dev
```

5. Build for production
```
npm run build
```

6. Start production server
```
npm start
```

## API Endpoints

### Auth
- `POST /api/users/login` - Login user
- `POST /api/users/register` - Register new user

### Users
- `GET /api/users/profile` - Get user profile
- `PUT /api/users/profile` - Update user profile

### Pets
- `GET /api/pets` - Get all pets
- `GET /api/pets/:id` - Get pet by ID
- `POST /api/pets` - Create new pet
- `PUT /api/pets/:id` - Update pet
- `DELETE /api/pets/:id` - Delete pet

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