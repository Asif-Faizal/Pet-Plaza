part of 'get_cart_items_bloc.dart';

abstract class GetCartItemsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends GetCartItemsState {}

class CartLoading extends GetCartItemsState {}

class CartLoaded extends GetCartItemsState {
  final GetCartEntity cart;
  CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CartError extends GetCartItemsState {
  final String message;
  CartError(this.message);

  @override
  List<Object?> get props => [message];
}