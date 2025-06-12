# PetPlaza Frontend

## Overview
This is the Flutter frontend for the PetPlaza application, supporting pet adoption, user registration, shopping, and more.

## Setup
1. Install dependencies:
   ```bash
   flutter pub get
   ```
2. Run the app:
   ```bash
   flutter run
   ```

## Features

### Splash
- Initial page and user type selection screens

### Login
- User login
- BLoC: `login_bloc.dart`, `login_event.dart`, `login_state.dart`
- Cubit: `login_cubit.dart`

### Register
- User and adoption centre registration
- Screens: `createacc.dart`, `passcode.dart`, `profilepic.dart`
- BLoC: `register_user_bloc.dart`, `register_user_event.dart`, `register_user_state.dart`

### Dashboard
- Home, profile, pet adoption, cart, and product browsing
- Screens: `homescreen.dart`, `profile.dart`, `adoptpets.dart`, `cart_screen.dart`, `pet_items_screen.dart`, `petdetails_screen.dart`, `adoption_request_screen.dart`, `user_adoption_requests.dart`, `addpetpage.dart`, `selectpettype.dart`, `accesssories_details.dart`
- BLoCs:
  - **Cart:**
    - Add: `add_to_cart_bloc.dart`, `add_to_cart_event.dart`, `add_to_cart_state.dart`
    - Delete: `delete_cart_item_bloc.dart`, `delete_cart_item_event.dart`, `delete_cart_item_state.dart`
    - Get: `get_cart_items_bloc.dart`, `get_cart_items_event.dart`, `get_cart_items_state.dart`
    - Update: `update_cart_item_bloc.dart`, `update_cart_item_event.dart`, `update_cart_item_state.dart`
  - **Pet Items:** `pet_items_bloc.dart`, `pet_items_event.dart`, `pet_items_state.dart`
  - **Adoption Requests:** `adoption_requests_bloc.dart`, `adoption_requests_event.dart`, `adoption_requests_state.dart`
  - **User Adoption Requests:** `user_adoption_requests_bloc.dart`, `user_adoption_requests_event.dart`, `user_adoption_requests_state.dart`
  - **Pet:** `pet_bloc.dart`, `pet_event.dart`, `pet_state.dart`

## Folder Structure
- `lib/features/` — Main features (dashboard, login, register, splash)
- Each feature contains `bloc/`, `domain/`, `presentation/`, and `data/` as needed

## Notes
- Uses BLoC and Cubit for state management
- See each feature's directory for more details
