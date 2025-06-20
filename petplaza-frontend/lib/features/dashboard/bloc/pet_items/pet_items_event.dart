part of 'pet_items_bloc.dart';

abstract class PetItemEvent extends Equatable {
  const PetItemEvent();

  @override
  List<Object?> get props => [];
}

class LoadPetItems extends PetItemEvent {}