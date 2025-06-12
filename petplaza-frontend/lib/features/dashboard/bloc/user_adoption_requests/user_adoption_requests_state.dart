part of 'user_adoption_requests_bloc.dart';

@immutable
sealed class UserAdoptionRequestsState {}

final class UserAdoptionRequestsInitial extends UserAdoptionRequestsState {}

final class UserAdoptionRequestsLoading extends UserAdoptionRequestsState {}

final class UserAdoptionRequestsLoaded extends UserAdoptionRequestsState {
  final List<UserAdoptionRequestEntity> requests;

  UserAdoptionRequestsLoaded({required this.requests});
}

final class UserAdoptionRequestsError extends UserAdoptionRequestsState {
  final String message;

  UserAdoptionRequestsError({required this.message});
}
