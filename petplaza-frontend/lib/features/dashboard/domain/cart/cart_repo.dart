import 'package:dartz/dartz.dart';

import 'add_to_cart_entity.dart';
import 'get_cart_entity.dart';

abstract class CartRepository {
  Future<Either<String, CartEntity>> addToCart(String productId, int quantity, String token);
  Future<Either<String, GetCartEntity>> getCartItems(String token);
}