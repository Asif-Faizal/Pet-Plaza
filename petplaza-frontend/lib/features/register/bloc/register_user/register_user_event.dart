part of 'register_user_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  final RegisterRequestModel request;

  RegisterUserEvent(this.request);
}