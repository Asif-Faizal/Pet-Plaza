import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'user_adoption_request_model.dart';

abstract class UserAdoptionRequestRemoteDataSource {
  Future<List<UserAdoptionRequestModel>> getUserAdoptionRequests(String token);
}

class UserAdoptionRequestRemoteDataSourceImpl implements UserAdoptionRequestRemoteDataSource {
  final http.Client client;

  UserAdoptionRequestRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserAdoptionRequestModel>> getUserAdoptionRequests(String token) async {
    final response = await client.get(
      Uri.parse('http://localhost:5000/api/adoption-requests/user'),
      headers: {'Authorization': 'Bearer $token'},
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> data = decoded['data'];
      return data.map((json) => UserAdoptionRequestModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch user adoption requests');
    }
  }
} 