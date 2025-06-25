import 'package:dartz/dartz.dart';
import 'order_entity.dart';

abstract class OrderRepository {
  Future<Either<String, OrderEntity>> placeOrder({
    required String street,
    required String city,
    required String state,
    required String postalCode,
    required String country,
    required String paymentMethod,
    required String token,
  });
} 