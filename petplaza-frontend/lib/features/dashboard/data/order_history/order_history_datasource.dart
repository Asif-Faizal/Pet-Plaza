import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../../core/api/api_config.dart';
import 'order_history_response_model.dart';

abstract class OrderHistoryRemoteDataSource {
  Future<OrderHistoryResponseModel> getOrderHistory({
    required String token,
  });
}

class OrderHistoryRemoteDataSourceImpl implements OrderHistoryRemoteDataSource {
  final http.Client client;

  OrderHistoryRemoteDataSourceImpl({required this.client});

  @override
  Future<OrderHistoryResponseModel> getOrderHistory({
    required String token,
  }) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConfig.baseUrl}/orders/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Order History Response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return OrderHistoryResponseModel.fromJson(jsonResponse);
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message'] ?? 'Failed to fetch order history');
      }
    } catch (e) {
      throw Exception('Failed to fetch order history: ${e.toString()}');
    }
  }
} 