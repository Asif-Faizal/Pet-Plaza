part of 'delete_cart_item_bloc.dart';

abstract class DeleteCartItemState extends Equatable {
  const DeleteCartItemState();

  @override
  List<Object> get props => [];
}

class DeleteCartItemInitial extends DeleteCartItemState {}

class DeleteCartItemLoading extends DeleteCartItemState {}

class DeleteCartItemSuccess extends DeleteCartItemState {
  final CartEntity cart;

  const DeleteCartItemSuccess(this.cart);

  @override
  List<Object> get props => [cart];
}

class DeleteCartItemError extends DeleteCartItemState {
  final String message;

  const DeleteCartItemError(this.message);

  @override
  List<Object> get props => [message];
} 