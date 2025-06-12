part of 'register_user_bloc.dart';

@immutable
sealed class RegisterUserState {}

final class RegisterUserInitial extends RegisterUserState {}

final class RegisterUserLoading extends RegisterUserState{}

final class RegisterUserSuccess extends RegisterUserState{
  final User user;

  RegisterUserSuccess(this.user);
}

final class RegisterUserFailure extends RegisterUserState{
  final String error;

  RegisterUserFailure(this.error);
}

final class RegisterUserServerError extends RegisterUserState{
  final String error;

  RegisterUserServerError(this.error);
}