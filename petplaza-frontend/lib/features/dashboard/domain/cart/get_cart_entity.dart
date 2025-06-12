import 'package:equatable/equatable.dart';

class GetCartProductEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final List<String> images;
  final int stock;

  const GetCartProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.images,
    required this.stock,
  });

  @override
  List<Object?> get props => [id, name, price, images, stock];
}

class GetCartItemEntity extends Equatable {
  final GetCartProductEntity product;
  final int quantity;
  final double price;

  const GetCartItemEntity({
    required this.product,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [product, quantity, price];
}

class GetCartEntity extends Equatable {
  final String id;
  final String userId;
  final List<GetCartItemEntity> items;
  final double totalAmount;

  const GetCartEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
  });

  @override
  List<Object?> get props => [id, userId, items, totalAmount];
}
