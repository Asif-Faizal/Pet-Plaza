import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/pet/pet_entity.dart';
import '../../domain/pet/pet_repo.dart';

part 'pet_event.dart';
part 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final PetRepository petRepository;
  String? currentPetType;
  String? currentStatus;

  PetBloc({required this.petRepository}) : super(PetInitial()) {
    on<LoadInitialPets>((event, emit) async {
      emit(PetLoading());
      final result = await petRepository.getFilteredPets(petType: '', status: '');
      result.fold(
        (failure) => emit(PetError(message: failure)),
        (pets) => emit(PetLoaded(pets: pets)),
      );
    });

    on<GetFilteredPets>((event, emit) async {
      emit(PetLoading());
      currentPetType = event.petType;
      currentStatus = event.status;
      final result = await petRepository.getFilteredPets(
        petType: event.petType,
        status: event.status,
      );
      result.fold(
        (failure) => emit(PetError(message: failure)),
        (pets) => emit(PetLoaded(pets: pets)),
      );
    });
  }
}
