import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String productId;
  final int quantity;
  final double price;

  const CartItemEntity({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [productId, quantity, price];
}

class CartEntity extends Equatable {
  final String id;
  final String userId;
  final List<CartItemEntity> items;
  final double totalAmount;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
  });

  @override
  List<Object?> get props => [id, userId, items, totalAmount];
}