import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/pet_items/pet_items_entity.dart';
import '../../domain/pet_items/pet_items_repo.dart';

part 'pet_items_event.dart';
part 'pet_items_state.dart';

class PetItemBloc extends Bloc<PetItemEvent, PetItemState> {
  final PetItemRepository repository;

  PetItemBloc(this.repository) : super(PetItemInitial()) {
    on<LoadPetItems>((event, emit) async {
      emit(PetItemLoading());
      final result = await repository.getPetItems();
      result.fold(
        (failure) => emit(PetItemError(failure)),
        (items) => emit(PetItemLoaded(items)),
      );
    });
  }
}