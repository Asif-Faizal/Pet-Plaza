import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  final String id;
  final String name;
  final String petType;
  final String breed;
  final String gender;
  final int age;
  final String ownerName;
  final String contactNumber;
  final String contactAddress;
  final String behavior;
  final String description;
  final List<String> imageUrls;
  final String adoptionCentreName;
  final String adoptionCentreLocation;
  final String status;

  const Pet({
    required this.id,
    required this.name,
    required this.petType,
    required this.breed,
    required this.gender,
    required this.age,
    required this.ownerName,
    required this.contactNumber,
    required this.contactAddress,
    required this.behavior,
    required this.description,
    required this.imageUrls,
    required this.adoptionCentreName,
    required this.adoptionCentreLocation,
    required this.status,
  });

  @override
  List<Object?> get props => [id, name, petType, breed, gender, age, status];
}
