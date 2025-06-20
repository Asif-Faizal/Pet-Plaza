import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petplaza/core/api/api_config.dart';

import '../../domain/cart/add_to_cart_entity.dart';
import '../../domain/cart/get_cart_entity.dart';
import 'add_to_cart_model.dart';
import 'get_cart_model.dart';


abstract class CartRemoteDataSource {
  Future<CartEntity> addToCart(String productId, int quantity,String token);
  Future<GetCartEntity> getCartItems(String token);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final http.Client client;

  CartRemoteDataSourceImpl(this.client);

  @override
  Future<CartEntity> addToCart(String productId, int quantity,String token) async {
    final response = await client.post(
      Uri.parse('${ApiConfig.baseUrl}/cart'),
      headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
      body: jsonEncode({"productId": productId, "quantity": quantity}),
    );
    debugPrint('Token: $token');
    debugPrint('Request URL: ${ApiConfig.baseUrl}/cart');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return CartModel.fromJson(decoded['data']);
    } else {
      throw Exception('Failed to add to cart');
    }
  }

   @override
  Future<GetCartEntity> getCartItems(String token) async {
    final response = await client.get(
      Uri.parse('${ApiConfig.baseUrl}/cart'),
      headers: {'Content-Type': 'application/json','Authorization':' Bearer $token'},
    );
    debugPrint('Token: $token');
    debugPrint('Request URL: ${ApiConfig.baseUrl}/cart');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return CartModelGet.fromJson(decoded['data']);
    } else {
      throw Exception('Failed to load cart items');
    }
  }
}