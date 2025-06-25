part of 'place_order_bloc.dart';

abstract class PlaceOrderEvent extends Equatable {
  const PlaceOrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrder extends PlaceOrderEvent {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String paymentMethod;
  final String token;

  const PlaceOrder({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.paymentMethod,
    required this.token,
  });

  @override
  List<Object> get props => [
        street,
        city,
        state,
        postalCode,
        country,
        paymentMethod,
        token,
      ];
} 