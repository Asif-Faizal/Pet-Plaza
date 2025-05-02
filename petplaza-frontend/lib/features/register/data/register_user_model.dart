import 'dart:io';

import '../domain/register_user_entity.dart';

class RegisterRequestModel {
  final String name;
  final String phoneNumber;
  final String email;
  final String location;
  final String passcode;
  final File? profilePic;
  final File? image;
  final String? managerName;
  final String? address;

  RegisterRequestModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.location,
    required this.passcode,
    this.profilePic,
    this.image,
    this.managerName,
    this.address,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    return RegisterRequestModel(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      location: json['location'],
      passcode: json['passcode'],
      profilePic: json['profilePic'],
      image: json['image'],
      managerName: json['managerName'],
      address: json['address'],
    );
  }
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
