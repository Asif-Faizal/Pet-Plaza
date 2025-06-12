import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_config.dart';
import 'adoption_request_model.dart';

abstract class PetAdoptionRemoteDataSource {
  Future<AdoptionResponseModel> submitAdoptionRequest(AdoptionRequestModel request, String token);
}

class PetAdoptionRemoteDataSourceImpl implements PetAdoptionRemoteDataSource {
  final http.Client client;

  PetAdoptionRemoteDataSourceImpl({required this.client});

  @override
  Future<AdoptionResponseModel> submitAdoptionRequest(AdoptionRequestModel request, String token) async {
    final response = await client.post(
      Uri.parse('${ApiConfig.baseUrl}/adoption-requests'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode(request.toJson()),
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return AdoptionResponseModel.fromJson(decoded);
    } else {
      throw Exception('Failed to submit adoption request');
    }
  }
}
