import 'package:equatable/equatable.dart';

class OrderHistoryEntity extends Equatable {
  final bool success;
  final int count;
  final List<OrderHistoryItemEntity> data;

  const OrderHistoryEntity({
    required this.success,
    required this.count,
    required this.data,
  });

  @override
  List<Object?> get props => [success, count, data];
}

class OrderHistoryItemEntity extends Equatable {
  final String id;
  final String user;
  final List<OrderItemHistoryEntity> items;
  final double totalAmount;
  final ShippingAddressHistoryEntity? shippingAddress;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final String createdAt;
  final String updatedAt;
  
  // Legacy fields for backward compatibility
  final String? product;
  final int? quantity;
  final double? totalPrice;
  final String? status;

  const OrderHistoryItemEntity({
    required this.id,
    required this.user,
    required this.items,
    required this.totalAmount,
    this.shippingAddress,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
    this.product,
    this.quantity,
    this.totalPrice,
    this.status,
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
        product,
        quantity,
        totalPrice,
        status,
      ];
}

class OrderItemHistoryEntity extends Equatable {
  final ProductHistoryEntity product;
  final int quantity;
  final double price;
  final String id;

  const OrderItemHistoryEntity({
    required this.product,
    required this.quantity,
    required this.price,
    required this.id,
  });

  @override
  List<Object?> get props => [product, quantity, price, id];
}

class ProductHistoryEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final List<String> images;

  const ProductHistoryEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.images,
  });

  @override
  List<Object?> get props => [id, name, price, images];
}

class ShippingAddressHistoryEntity extends Equatable {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String id;

  const ShippingAddressHistoryEntity({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.id,
  });

  @override
  List<Object?> get props => [street, city, state, postalCode, country, id];
} 