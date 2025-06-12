part of 'pet_bloc.dart';

@immutable
sealed class PetEvent {}

class LoadInitialPets extends PetEvent {}

class GetFilteredPets extends PetEvent {
  final String petType;
  final String status;

  GetFilteredPets({required this.petType, required this.status});
}
