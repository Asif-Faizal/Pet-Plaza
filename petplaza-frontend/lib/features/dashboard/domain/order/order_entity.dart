import 'package:equatable/equatable.dart';

class ShippingAddressEntity extends Equatable {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  const ShippingAddressEntity({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  @override
  List<Object?> get props => [street, city, state, postalCode, country];
}

class OrderItemEntity extends Equatable {
  final OrderProductEntity product;
  final int quantity;
  final double price;
  final String id;

  const OrderItemEntity({
    required this.product,
    required this.quantity,
    required this.price,
    required this.id,
  });

  @override
  List<Object?> get props => [product, quantity, price, id];
}

class OrderProductEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String petType;
  final String category;
  final List<String> images;
  final int stock;
  final String createdAt;
  final String updatedAt;

  const OrderProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.petType,
    required this.category,
    required this.images,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        petType,
        category,
        images,
        stock,
        createdAt,
        updatedAt,
      ];
}

class OrderEntity extends Equatable {
  final String id;
  final String user;
  final List<OrderItemEntity> items;
  final double totalAmount;
  final ShippingAddressEntity shippingAddress;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final String createdAt;
  final String updatedAt;

  const OrderEntity({
    required this.id,
    required this.user,
    required this.items,
    required this.totalAmount,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        items,
        totalAmount,
        shippingAddress,
        paymentMethod,
        paymentStatus,
        orderStatus,
        createdAt,
        updatedAt,
      ];
} 