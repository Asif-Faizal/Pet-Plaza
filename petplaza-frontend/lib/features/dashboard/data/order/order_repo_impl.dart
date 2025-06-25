import 'package:dartz/dartz.dart';
import '../../domain/order/order_entity.dart';
import '../../domain/order/order_repo.dart';
import 'order_datasource.dart';
import 'place_order_request_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, OrderEntity>> placeOrder({
    required String street,
    required String city,
    required String state,
    required String postalCode,
    required String country,
    required String paymentMethod,
    required String token,
  }) async {
    try {
      final request = PlaceOrderRequestModel(
        shippingAddress: ShippingAddressRequestModel(
          street: street,
          city: city,
          state: state,
          postalCode: postalCode,
          country: country,
        ),
        paymentMethod: paymentMethod,
      );

      final response = await remoteDataSource.placeOrder(
        request: request,
        token: token,
      );

      return Right(response.data.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }
} 