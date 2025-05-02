// lib/features/login/domain/entities/login_user.dart
import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String userType;
  final bool isAdmin;
  final String token;
  final String managerName;
  final String address;
  final String imageUrl;

  const LoginEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.isAdmin,
    required this.token,
    required this.managerName,
    required this.address,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [
    id, name, email, phoneNumber, userType, isAdmin,
    token, managerName, address, imageUrl
  ];
}
