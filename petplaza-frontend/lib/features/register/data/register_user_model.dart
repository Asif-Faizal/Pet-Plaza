import 'dart:io';

import '../domain/register_user_entity.dart';

class RegisterRequestModel {
  final String name;
  final String phoneNumber;
  final String email;
  final String location;
  final String passcode;
  final File profilePic;

  RegisterRequestModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.location,
    required this.passcode,
    required this.profilePic,
  });
}

// Response Model
class RegisterResponseModel extends User {
  const RegisterResponseModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.userType,
    required super.profilePicUrl,
    required super.token,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      userType: json['userType'],
      profilePicUrl: json['profilePicUrl'],
      token: json['token'],
    );
  }
}
