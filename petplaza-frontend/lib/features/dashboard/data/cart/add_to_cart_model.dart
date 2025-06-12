import '../../domain/cart/add_to_cart_entity.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.productId,
    required super.quantity,
    required super.price,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        productId: json['product'],
        quantity: json['quantity'],
        price: double.parse(json['price']['\$numberDecimal']),
      );
}

class CartModel extends CartEntity {
  const CartModel({
    required super.id,
    required super.userId,
    required super.items,
    required super.totalAmount,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['_id'],
        userId: json['user'],
        items: List<CartItemEntity>.from(
            json['items'].map((x) => CartItemModel.fromJson(x))),
        totalAmount: json['totalAmount'].toDouble(),
      );
}