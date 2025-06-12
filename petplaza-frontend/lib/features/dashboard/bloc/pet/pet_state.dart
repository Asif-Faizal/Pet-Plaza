part of 'pet_bloc.dart';

@immutable
sealed class PetState {}

final class PetInitial extends PetState {}

final class PetLoading extends PetState {}

final class PetLoaded extends PetState {
  final List<Pet> pets;

  PetLoaded({required this.pets});
}

final class PetError extends PetState {
  final String message;

  PetError({required this.message});
}
