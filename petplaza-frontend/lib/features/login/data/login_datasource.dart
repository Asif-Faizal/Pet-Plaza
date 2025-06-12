import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:petplaza/core/api/api_config.dart';

import 'package:petplaza/features/login/data/login_request_model.dart';
import 'package:petplaza/features/login/data/login_response_model.dart';

abstract class LoginDataSource{
  Future<LoginResponseModel> login(LoginRequestModel request);
}

class LoginDataSourceImpl implements LoginDataSource{
  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    debugPrint(request.toJson().toString());
    debugPrint(response.body);
    final message = jsonDecode(response.body)['message'];
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(message);
    }
  }
}