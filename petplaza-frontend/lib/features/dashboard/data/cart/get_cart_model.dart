import 'package:petplaza/features/dashboard/domain/cart/get_cart_entity.dart';

class GetCartProductModel extends GetCartProductEntity {
  const GetCartProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.images,
    required super.stock,
  });

  factory GetCartProductModel.fromJson(Map<String, dynamic> json) {
    return GetCartProductModel(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      stock: json['stock'],
    );
  }
}

class GetCartItemModel extends GetCartItemEntity {
  const GetCartItemModel({
    required super.product,
    required super.quantity,
    required super.price,
  });

  factory GetCartItemModel.fromJson(Map<String, dynamic> json) {
    return GetCartItemModel(
      product: GetCartProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      price: _parseDecimal(json['price']),
    );
  }

  static double _parseDecimal(dynamic priceJson) {
    if (priceJson is Map && priceJson.containsKey('\$numberDecimal')) {
      return double.tryParse(priceJson['\$numberDecimal'].toString()) ?? 0.0;
    }
    return (priceJson as num).toDouble();
  }
}

class CartModelGet extends GetCartEntity {
  const CartModelGet({
    required super.id,
    required super.userId,
    required super.items,
    required super.totalAmount,
  });

  factory CartModelGet.fromJson(Map<String, dynamic> json) {
    return CartModelGet(
      id: json['_id'],
      userId: json['user'],
      items: List<GetCartItemEntity>.from(
        json['items'].map((x) => GetCartItemModel.fromJson(x)),
      ),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );
  }
}
