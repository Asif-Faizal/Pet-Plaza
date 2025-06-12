part of 'user_adoption_requests_bloc.dart';

@immutable
sealed class UserAdoptionRequestsEvent {}

class GetUserAdoptionRequests extends UserAdoptionRequestsEvent {
  final String token;

  GetUserAdoptionRequests({required this.token});
}