import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_config.dart';
import 'pet_request_model.dart';
import 'pet_response_model.dart';

abstract class PetRemoteDatasource {
  Future<List<PetResponseModel>> getFilteredPets(PetRequestModel request);
}

class PetRemoteDatasourceImpl implements PetRemoteDatasource {
  final http.Client client;

  PetRemoteDatasourceImpl({required this.client});

  @override
  Future<List<PetResponseModel>> getFilteredPets(PetRequestModel request) async {
    final queryParams = request.toQueryParams();
    final petType = queryParams['petType'] ?? '';
    final status = queryParams['status'] ?? '';
    
    final uri = Uri.parse('${ApiConfig.baseUrl}/pets/filter?petType=$petType&status=$status');
    final response = await client.get(uri);
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List<dynamic> data = jsonBody['data'] ?? [];
      return PetResponseModel.fromJsonList(data);
    } else {
      throw Exception('Failed to load pets');
    }
  }
}
