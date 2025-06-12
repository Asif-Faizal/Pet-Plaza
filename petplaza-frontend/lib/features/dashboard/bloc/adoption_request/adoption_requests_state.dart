part of 'adoption_requests_bloc.dart';

@immutable
sealed class AdoptionRequestsState {}

final class AdoptionRequestsInitial extends AdoptionRequestsState {}

final class AdoptionRequestLoading extends AdoptionRequestsState {}

final class AdoptionRequestSuccess extends AdoptionRequestsState {
  final AdoptionRequestEntity adoptionRequest;

  AdoptionRequestSuccess({required this.adoptionRequest});
}

final class AdoptionRequestFailure extends AdoptionRequestsState {
  final String error;

  AdoptionRequestFailure({required this.error});
}
