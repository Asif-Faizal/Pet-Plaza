part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String identifier;
  final String passcode;

  LoginButtonPressed({required this.identifier, required this.passcode});
}