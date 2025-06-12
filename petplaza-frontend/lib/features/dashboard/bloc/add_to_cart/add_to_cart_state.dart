part of 'add_to_cart_bloc.dart';

abstract class AddToCartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends AddToCartState {}

class CartLoading extends AddToCartState {}

class CartLoaded extends AddToCartState {
  final CartEntity cart;
  CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CartError extends AddToCartState {
  final String message;
  CartError(this.message);

  @override
  List<Object?> get props => [message];
}