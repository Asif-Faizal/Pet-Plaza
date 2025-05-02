import 'package:petplaza/features/login/domain/login_entity.dart';

class LoginResponseModel extends LoginEntity{
  const LoginResponseModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.userType,
    required super.isAdmin,
    required super.token,
    required super.managerName,
    required super.address,
    required super.imageUrl,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return LoginResponseModel(
      id: data['_id'],
      name: data['name'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      userType: data['userType'],
      isAdmin: data['isAdmin'],
      token: data['token'],
      managerName: '', // Optional field
      address: '', // Optional field
      imageUrl: data['profilePicUrl'] ?? '', // Using profilePicUrl from response
    );
  }

  @override
  List<Object> get props => [id, name, email, phoneNumber, userType, isAdmin, token, managerName, address, imageUrl];
}
