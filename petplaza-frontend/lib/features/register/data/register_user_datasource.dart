import 'dart:convert';

import 'package:flutter/material.dart';

import 'register_user_model.dart';
import'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<RegisterResponseModel> registerUser(RegisterRequestModel request);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  
  UserRemoteDataSourceImpl({required this.client});
  
  @override
  Future<RegisterResponseModel> registerUser(RegisterRequestModel request) async {
    var uri = Uri.parse('http://192.168.0.119:5000/api/users/register/user');
    var requestBody = http.MultipartRequest('POST', uri)
      ..fields['name'] = request.name
      ..fields['phoneNumber'] = request.phoneNumber
      ..fields['email'] = request.email
      ..fields['location'] = request.location
      ..fields['passcode'] = request.passcode
      ..files.add(await http.MultipartFile.fromPath('profilePic', request.profilePic.path));
    debugPrint(request.toString());
    var response = await requestBody.send();
    var responseData = await http.Response.fromStream(response);
    debugPrint("$responseData");
    
    if (response.statusCode == 201) {
      return RegisterResponseModel.fromJson(json.decode(responseData.body));
    } else {
      throw Exception('Failed to register user');
    }
  }
}
