import '../../domain/order_history/order_history_entity.dart';

class OrderHistoryResponseModel {
  final bool success;
  final int count;
  final List<OrderHistoryItemModel> data;

  OrderHistoryResponseModel({
    required this.success,
    required this.count,
    required this.data,
  });

  factory OrderHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryResponseModel(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => OrderHistoryItemModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  OrderHistoryEntity toEntity() {
    return OrderHistoryEntity(
      success: success,
      count: count,
      data: data.map((item) => item.toEntity()).toList(),
    );
  }
}

class OrderHistoryItemModel {
  final String id;
  final String user;
  final List<OrderItemHistoryModel> items;
  final double totalAmount;
  final ShippingAddressHistoryModel? shippingAddress;
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

  OrderHistoryItemModel({
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

  factory OrderHistoryItemModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryItemModel(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => OrderItemHistoryModel.fromJson(item))
              .toList() ??
          [],
      totalAmount: (json['totalAmount'] ?? json['totalPrice'] ?? 0).toDouble(),
      shippingAddress: json['shippingAddress'] != null
          ? ShippingAddressHistoryModel.fromJson(json['shippingAddress'])
          : null,
      paymentMethod: json['paymentMethod'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      orderStatus: json['orderStatus'] ?? json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      product: json['product'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice']?.toDouble(),
      status: json['status'],
    );
  }

  OrderHistoryItemEntity toEntity() {
    return OrderHistoryItemEntity(
      id: id,
      user: user,
      items: items.map((item) => item.toEntity()).toList(),
      totalAmount: totalAmount,
      shippingAddress: shippingAddress?.toEntity(),
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus,
      orderStatus: orderStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
      product: product,
      quantity: quantity,
      totalPrice: totalPrice,
      status: status,
    );
  }
}

class OrderItemHistoryModel {
  final ProductHistoryModel product;
  final int quantity;
  final double price;
  final String id;

  OrderItemHistoryModel({
    required this.product,
    required this.quantity,
    required this.price,
    required this.id,
  });

  factory OrderItemHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderItemHistoryModel(
      product: ProductHistoryModel.fromJson(json['product']),
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      id: json['_id'] ?? '',
    );
  }

  OrderItemHistoryEntity toEntity() {
    return OrderItemHistoryEntity(
      product: product.toEntity(),
      quantity: quantity,
      price: price,
      id: id,
    );
  }
}

class ProductHistoryModel {
  final String id;
  final String name;
  final double price;
  final List<String> images;

  ProductHistoryModel({
    required this.id,
    required this.name,
    required this.price,
    required this.images,
  });

  factory ProductHistoryModel.fromJson(Map<String, dynamic> json) {
    return ProductHistoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      images: List<String>.from(json['images'] ?? []),
    );
  }

  ProductHistoryEntity toEntity() {
    return ProductHistoryEntity(
      id: id,
      name: name,
      price: price,
      images: images,
    );
  }
}

class ShippingAddressHistoryModel {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String id;

  ShippingAddressHistoryModel({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.id,
  });

  factory ShippingAddressHistoryModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressHistoryModel(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  ShippingAddressHistoryEntity toEntity() {
    return ShippingAddressHistoryEntity(
      street: street,
      city: city,
      state: state,
      postalCode: postalCode,
      country: country,
      id: id,
    );
  }
} 