import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../../core/api/api_config.dart';
import 'place_order_request_model.dart';
import 'place_order_response_model.dart';

abstract class OrderRemoteDataSource {
  Future<PlaceOrderResponseModel> placeOrder({
    required PlaceOrderRequestModel request,
    required String token,
  });
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;

  OrderRemoteDataSourceImpl({required this.client});

  @override
  Future<PlaceOrderResponseModel> placeOrder({
    required PlaceOrderRequestModel request,
    required String token,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConfig.baseUrl}/orders'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );
      debugPrint(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return PlaceOrderResponseModel.fromJson(jsonResponse);
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message'] ?? 'Failed to place order');
      }
    } catch (e) {
      throw Exception('Failed to place order: ${e.toString()}');
    }
  }
} 