part of 'update_cart_item_bloc.dart';

abstract class UpdateCartItemState extends Equatable {
  const UpdateCartItemState();

  @override
  List<Object> get props => [];
}

class UpdateCartItemInitial extends UpdateCartItemState {}

class UpdateCartItemLoading extends UpdateCartItemState {}

class UpdateCartItemSuccess extends UpdateCartItemState {
  final CartEntity cart;

  const UpdateCartItemSuccess(this.cart);

  @override
  List<Object> get props => [cart];
}

class UpdateCartItemError extends UpdateCartItemState {
  final String message;

  const UpdateCartItemError(this.message);

  @override
  List<Object> get props => [message];
} 