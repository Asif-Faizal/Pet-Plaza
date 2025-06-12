part of 'get_cart_items_bloc.dart';

abstract class GetCartItemsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCartItems extends GetCartItemsEvent {
  final String token;

  GetCartItems(this.token);

  @override
  List<Object> get props => [token];
}
