import 'package:equatable/equatable.dart';

class UserAdoptionRequestEntity extends Equatable {
  final String id;
  final String note;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AdoptionRequestPetEntity pet;
  final AdoptionCentreEntity? adoptionCentre;

  const UserAdoptionRequestEntity({
    required this.id,
    required this.note,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.pet,
    this.adoptionCentre,
  });

  @override
  List<Object?> get props => [id, note, status, createdAt, updatedAt, pet, adoptionCentre];
}

class AdoptionRequestPetEntity extends Equatable {
  final String id;
  final String name;
  final String petType;
  final String breed;
  final List<String> images;
  final String status;

  const AdoptionRequestPetEntity({
    required this.id,
    required this.name,
    required this.petType,
    required this.breed,
    required this.images,
    required this.status,
  });

  @override
  List<Object?> get props => [id, name, petType, breed, images, status];
}

class AdoptionCentreEntity extends Equatable {
  final String id;
  final String name;
  final String location;
  final String? contactNumber;
  final String? contactAddress;
  final String? email;

  const AdoptionCentreEntity({
    required this.id,
    required this.name,
    required this.location,
    this.contactNumber,
    this.contactAddress,
    this.email,
  });

  @override
  List<Object?> get props => [id, name, location, contactNumber, contactAddress, email];
}
