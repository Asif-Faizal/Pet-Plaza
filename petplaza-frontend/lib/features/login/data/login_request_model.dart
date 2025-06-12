// lib/features/login/data/models/login_request_model.dart
import 'package:equatable/equatable.dart';

class LoginRequestModel  extends Equatable{
  final String identifier;
  final String passcode;

  const LoginRequestModel({required this.identifier, required this.passcode});

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'passcode': passcode,
    };
  }

  @override
  List<Object?> get props => [identifier, passcode];
}
