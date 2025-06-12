import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/adoption_request/adoption_request_model.dart';
import '../../domain/adoption_request/adoption_request_entity.dart';
import '../../domain/adoption_request/adoption_request_repo.dart';

part 'adoption_requests_event.dart';
part 'adoption_requests_state.dart';

class AdoptionRequestsBloc extends Bloc<AdoptionRequestsEvent, AdoptionRequestsState> {
  final PetAdoptionRepository petAdoptionRepository;
  AdoptionRequestsBloc({required this.petAdoptionRepository}) : super(AdoptionRequestsInitial()) {
    on<SubmitAdoptionRequest>((event, emit) async {
      emit(AdoptionRequestLoading());
      final result = await petAdoptionRepository.submitAdoptionRequest(event.request, event.token);
      result.fold(
        (failure) => emit(AdoptionRequestFailure(error: failure)),
        (adoptionRequest) => emit(AdoptionRequestSuccess(adoptionRequest: adoptionRequest)),
      );
    });
  }
}
