import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/user_adoption_requests/user_adoption_request_entity.dart';
import '../../domain/user_adoption_requests/user_adoption_request_repo.dart';

part 'user_adoption_requests_event.dart';
part 'user_adoption_requests_state.dart';

class UserAdoptionRequestsBloc extends Bloc<UserAdoptionRequestsEvent, UserAdoptionRequestsState> {
  final UserAdoptionRequestRepository userAdoptionRequestRepository;
  UserAdoptionRequestsBloc({required this.userAdoptionRequestRepository}) : super(UserAdoptionRequestsInitial()) {
    on<GetUserAdoptionRequests>((event, emit) async {
      emit(UserAdoptionRequestsLoading());
      final result = await userAdoptionRequestRepository.getUserAdoptionRequests(event.token);
      result.fold((l) => emit(UserAdoptionRequestsError(message: l)), (r) => emit(UserAdoptionRequestsLoaded(requests: r)));
    });
  }
}
