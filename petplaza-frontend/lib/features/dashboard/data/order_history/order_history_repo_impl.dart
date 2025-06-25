import 'package:dartz/dartz.dart';
import '../../domain/order_history/order_history_entity.dart';
import '../../domain/order_history/order_history_repo.dart';
import 'order_history_datasource.dart';

class OrderHistoryRepositoryImpl implements OrderHistoryRepository {
  final OrderHistoryRemoteDataSource remoteDataSource;

  OrderHistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, OrderHistoryEntity>> getOrderHistory({
    required String token,
  }) async {
    try {
      final response = await remoteDataSource.getOrderHistory(token: token);
      return Right(response.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }
} 