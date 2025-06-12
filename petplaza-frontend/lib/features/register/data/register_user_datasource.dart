import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import '../../../core/api/api_config.dart';
import 'register_user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<RegisterResponseModel> registerUser(RegisterRequestModel request, bool isIndividual);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<RegisterResponseModel> registerUser(
      RegisterRequestModel request, bool isIndividual) async {
    var uri = Uri.parse('${ApiConfig.baseUrl}/users/register/user');
    var requestBody = http.MultipartRequest('POST', uri);

    debugPrint("Request URL: $uri");

    // Common fields for both individual and non-individual
    requestBody.fields['name'] = request.name;
    requestBody.fields['phoneNumber'] = request.phoneNumber;
    requestBody.fields['email'] = request.email;
    requestBody.fields['location'] = request.location;
    requestBody.fields['passcode'] = request.passcode;

    if (isIndividual) {
      // Add profile picture for individual users
      if (request.profilePic != null) {
        requestBody.files.add(
          await http.MultipartFile.fromPath(
            'profilePic',
            request.profilePic!.path,
            contentType: MediaType('image', 'jpg'),
          ),
        );
      }
    } else {
      // Additional fields for non-individual users
      requestBody.fields['managerName'] = request.managerName ?? '';
      requestBody.fields['address'] = request.address ?? '';
      
      // Add image for non-individual users
      if (request.image != null) {
        requestBody.files.add(
          await http.MultipartFile.fromPath(
            'image',
            request.image!.path,
            contentType: MediaType('image', 'jpg'),
          ),
        );
      }
    }

    debugPrint(request.name);
    debugPrint(request.phoneNumber);
    debugPrint(request.email);
    debugPrint(request.location);
    debugPrint(request.passcode);
    debugPrint(request.managerName);
    debugPrint(request.address);
    var response = await requestBody.send();
    var responseData = await http.Response.fromStream(response);
    debugPrint("${responseData.statusCode}");
    debugPrint(responseData.body);

    if (response.statusCode == 201) {
      return RegisterResponseModel.fromJson(json.decode(responseData.body));
    } else {
      throw Exception('Failed to register user');
    }
  }
}
