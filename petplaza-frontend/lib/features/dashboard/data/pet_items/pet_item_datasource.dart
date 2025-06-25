import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_config.dart';
import 'pet_items_model.dart';

abstract class PetItemRemoteDataSource {
  Future<List<PetItemModel>> fetchPetItems();
}

class PetItemRemoteDataSourceImpl implements PetItemRemoteDataSource {
  final http.Client client;

  PetItemRemoteDataSourceImpl(this.client);

  @override
  Future<List<PetItemModel>> fetchPetItems() async {
    final response = await client.get(Uri.parse('${ApiConfig.baseUrl}/pet-products'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List items = body['data'];
      return items.map((item) => PetItemModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load pet items');
    }
  }
}
