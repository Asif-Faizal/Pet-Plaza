import 'package:dartz/dartz.dart';
import 'order_history_entity.dart';

abstract class OrderHistoryRepository {
  Future<Either<String, OrderHistoryEntity>> getOrderHistory({
    required String token,
  });
} 