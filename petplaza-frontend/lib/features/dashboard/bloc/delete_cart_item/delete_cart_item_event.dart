part of 'delete_cart_item_bloc.dart';

abstract class DeleteCartItemEvent extends Equatable {
  const DeleteCartItemEvent();

  @override
  List<Object> get props => [];
}

class DeleteCartItem extends DeleteCartItemEvent {
  final String productId;
  final String token;

  const DeleteCartItem(this.productId, this.token);

  @override
  List<Object> get props => [productId, token];
} 