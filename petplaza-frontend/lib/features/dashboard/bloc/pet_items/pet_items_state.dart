part of 'pet_items_bloc.dart';

abstract class PetItemState extends Equatable {
  const PetItemState();

  @override
  List<Object?> get props => [];
}

class PetItemInitial extends PetItemState {}

class PetItemLoading extends PetItemState {}

class PetItemLoaded extends PetItemState {
  final List<PetItem> items;

  const PetItemLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class PetItemError extends PetItemState {
  final String message;

  const PetItemError(this.message);

  @override
  List<Object?> get props => [message];
}