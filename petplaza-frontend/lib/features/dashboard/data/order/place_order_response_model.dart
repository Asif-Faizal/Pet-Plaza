import '../../domain/order/order_entity.dart';

class PlaceOrderResponseModel {
  final bool success;
  final OrderModel data;

  PlaceOrderResponseModel({
    required this.success,
    required this.data,
  });

  factory PlaceOrderResponseModel.fromJson(Map<String, dynamic> json) {
    return PlaceOrderResponseModel(
      success: json['success'] ?? false,
      data: OrderModel.fromJson(json['data']),
    );
  }
}

class OrderModel {
  final String id;
  final String user;
  final List<OrderItemModel> items;
  final double totalAmount;
  final ShippingAddressModel shippingAddress;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final String createdAt;
  final String updatedAt;

  OrderModel({
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

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => OrderItemModel.fromJson(item))
              .toList() ??
          [],
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      shippingAddress: ShippingAddressModel.fromJson(json['shippingAddress']),
      paymentMethod: json['paymentMethod'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      user: user,
      items: items.map((item) => item.toEntity()).toList(),
      totalAmount: totalAmount,
      shippingAddress: shippingAddress.toEntity(),
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus,
      orderStatus: orderStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class OrderItemModel {
  final OrderProductModel product;
  final int quantity;
  final double price;
  final String id;

  OrderItemModel({
    required this.product,
    required this.quantity,
    required this.price,
    required this.id,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      product: OrderProductModel.fromJson(json['product']),
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      id: json['_id'] ?? '',
    );
  }

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      product: product.toEntity(),
      quantity: quantity,
      price: price,
      id: id,
    );
  }
}

class OrderProductModel {
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

  OrderProductModel({
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

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      petType: json['petType'] ?? '',
      category: json['category'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      stock: json['stock'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  OrderProductEntity toEntity() {
    return OrderProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      petType: petType,
      category: category,
      images: images,
      stock: stock,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class ShippingAddressModel {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  ShippingAddressModel({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'] ?? '',
    );
  }

  ShippingAddressEntity toEntity() {
    return ShippingAddressEntity(
      street: street,
      city: city,
      state: state,
      postalCode: postalCode,
      country: country,
    );
  }
} 