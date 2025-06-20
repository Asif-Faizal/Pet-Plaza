part of 'add_to_cart_bloc.dart';

abstract class AddToCartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCart extends AddToCartEvent {
  final String productId;
  final int quantity;
  final String token;

  AddToCart(this.productId, this.quantity, this.token);

  @override
  List<Object> get props => [productId, quantity,token];
}