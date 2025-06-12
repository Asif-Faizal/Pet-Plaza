import 'package:dartz/dartz.dart';

import '../../domain/cart/add_to_cart_entity.dart';
import '../../domain/cart/cart_repo.dart';
import '../../domain/cart/get_cart_entity.dart';
import 'cart_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource dataSource;

  CartRepositoryImpl(this.dataSource);

  @override
  Future<Either<String, CartEntity>> addToCart(String productId, int quantity, String token) async {
    try {
      final result = await dataSource.addToCart(productId, quantity,token);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

    @override
  Future<Either<String, GetCartEntity>> getCartItems(String token) async {
    try {
      final result = await dataSource.getCartItems(token);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}