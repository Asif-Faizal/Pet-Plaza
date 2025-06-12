part of 'update_cart_item_bloc.dart';

abstract class UpdateCartItemEvent extends Equatable {
  const UpdateCartItemEvent();

  @override
  List<Object> get props => [];
}

class UpdateCartItem extends UpdateCartItemEvent {
  final String productId;
  final int quantity;
  final String token;

  const UpdateCartItem(this.productId, this.quantity, this.token);

  @override
  List<Object> get props => [productId, quantity, token];
} 