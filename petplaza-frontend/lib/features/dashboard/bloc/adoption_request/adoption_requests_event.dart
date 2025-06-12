part of 'adoption_requests_bloc.dart';

@immutable
sealed class AdoptionRequestsEvent {}

class SubmitAdoptionRequest extends AdoptionRequestsEvent {
  final AdoptionRequestModel request;
  final String token;

  SubmitAdoptionRequest({required this.request, required this.token});
}
