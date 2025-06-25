part of 'place_order_bloc.dart';

abstract class PlaceOrderState extends Equatable {
  const PlaceOrderState();

  @override
  List<Object> get props => [];
}

class PlaceOrderInitial extends PlaceOrderState {}

class PlaceOrderLoading extends PlaceOrderState {}

class PlaceOrderSuccess extends PlaceOrderState {
  final OrderEntity order;

  const PlaceOrderSuccess(this.order);

  @override
  List<Object> get props => [order];
}

class PlaceOrderError extends PlaceOrderState {
  final String message;

  const PlaceOrderError(this.message);

  @override
  List<Object> get props => [message];
} 